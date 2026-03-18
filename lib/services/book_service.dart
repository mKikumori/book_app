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
      final doc = await _firestore.collection('book_collection').doc(uid).get();
      if (!doc.exists) return null;
      return custom.Book.fromFirestore(doc);
    } catch (e) {
      return null;
    }
  }

  /// Saves a new Book to book_collections with default settings
  Future<void> saveNewBook({
    required String uid,
    required String name,
    required int totalPageCount,
  }) async {
    try {
      final now = FieldValue.serverTimestamp();
      await _firestore.collection('book_collection').doc(uid).set({
        'created_at': now,
        'updated_at': now,
        'photo_url': null,
        'author_name': null,
        'description': null,
        'name': name,
        'total_page_count': totalPageCount,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Updates specific fields of an existing Book from book_collection
  Future<void> updateBookField(
    String uid,
    Map<String, dynamic> updates,
  ) async {
    try {
      updates['updated_at'] = FieldValue.serverTimestamp();
      await _firestore.collection('book_collection').doc(uid).update(updates);
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a specific Book from book_collection
  Future<void> deleteBook(String uid) async {
    try {
      await _firestore.collection('book_collection').doc(uid).delete();
    } catch (e) {
      rethrow;
    }
  }
}
