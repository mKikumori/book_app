import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_app/models/book.dart' as custom;

class BookService {
  final FirebaseFirestore _firestore;

  BookService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Retrieves the book data for a given UID from book_collection
  Future<custom.Book?> getBook(String uid) async {
    try {
      final doc = await _firestore
          .collection('userprofiles')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('book_collection')
          .doc(uid)
          .get();
      if (!doc.exists) return null;
      return custom.Book.fromFirestore(doc);
    } catch (e) {
      return null;
    }
  }

  /// Streams all books from book_collection in real-time
  Stream<List<custom.Book>> getBooks() {
    return FirebaseFirestore.instance
        .collection('userprofiles')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('book_collection')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return custom.Book.fromFirestore(doc);
      }).toList();
    });
  }

  /// Saves a new Book to book_collections with default settings
  Future<void> saveNewBook({
    required String name,
    required int totalPageCount,
    required String userId,
    String? authorName,
    String? photoUrl,
    int? currentPage,
  }) async {
    try {
      final now = FieldValue.serverTimestamp();

      await _firestore
          .collection('userprofiles')
          .doc(userId)
          .collection('book_collection')
          .add({
        'created_at': now,
        'updated_at': now,
        'photo_url': photoUrl,
        'author_name': authorName,
        'name': name,
        'total_page_count': totalPageCount,
        'current_page': currentPage ?? 0,
        'reader_progress': (currentPage != null && totalPageCount > 0)
            ? ((currentPage * 100) / totalPageCount).round()
            : 0,
      });
    } catch (e, stack) {
      print('ERROR saving book: $e');
      print(stack);
      throw Exception('Book creation failed: $e');
    }
  }

  /// Updates specific fields of an existing Book from book_collection
  Future<void> updateBookField(
    String uid,
    Map<String, dynamic> updates,
  ) async {
    try {
      updates['updated_at'] = FieldValue.serverTimestamp();
      await _firestore
          .collection('userprofiles')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('book_collection')
          .doc(uid)
          .update(updates);
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a specific Book from book_collection
  Future<void> deleteBook(String uid) async {
    try {
      await _firestore
          .collection('userprofiles')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('book_collection')
          .doc(uid)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> startReading(String uid) async {
    await _firestore
        .collection('userprofiles')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('book_collection')
        .doc(uid)
        .update({
      'last_start_time': FieldValue.serverTimestamp(),
    });
  }

  Future<void> stopReading(String uid) async {
    final doc = await _firestore
        .collection('userprofiles')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('book_collection')
        .doc(uid)
        .get();

    final data = doc.data()!;
    final lastStart = data['last_start_time'];

    if (lastStart == null) return;

    final startTime = (lastStart as Timestamp).toDate();
    final now = DateTime.now();
    final sessionTime = now.difference(startTime).inSeconds;

    final total = data['total_reading_time'] ?? 0;

    await _firestore
        .collection('userprofiles')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('book_collection')
        .doc(uid)
        .update({
      'total_reading_time': total + sessionTime,
      'last_start_time': null,
    });
  }
}
