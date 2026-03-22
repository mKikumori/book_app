import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  // Firebase Auth Attributes
  final String uid;
  final String? name;
  final String? authorName;
  final int? totalPageCount;
  final String? photoURL;
  final String? description;
  final int? currentPage;
  final int? readerProgress;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.uid,
    this.photoURL,
    required this.name,
    this.authorName,
    required this.totalPageCount,
    this.description,
    this.currentPage,
    this.readerProgress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book(
      uid: doc.id,
      photoURL: data['photo_url'] as String?,
      name: data['name'] as String? ?? '',
      authorName: data['author_name'] as String?,
      totalPageCount: data['total_page_count'] as int? ?? 1,
      description: data['description'] as String?,
      currentPage: data['current_page'] as int? ?? 0,
      readerProgress: data['reader_progress'] as int?,
      createdAt: parseDateTime(data['created_at']),
      updatedAt: parseDateTime(data['updated_at']),
    );
  }

  static DateTime parseDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  Map<String, dynamic> toFirestore() {
    return {
      'photo_url': photoURL,
      'name': name,
      'author_name': authorName,
      'total_page_count': totalPageCount,
      'description': description,
      'current_page': currentPage,
      'reader_progress': ((currentPage! * 100) / totalPageCount!).round(),
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}
