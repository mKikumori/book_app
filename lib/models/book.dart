import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String uid;
  final String? name;
  final String? authorName;
  final int? totalPageCount;
  final String? photoURL;
  final int? currentPage;
  final int? readerProgress;
  final int totalReadingTime;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastStartTime;

  bool get isReading => lastStartTime != null;

  int get currentReadingTime {
    if (lastStartTime == null) return totalReadingTime;

    final now = DateTime.now();
    return totalReadingTime + now.difference(lastStartTime!).inSeconds;
  }

  String get formattedReadingTime {
    final seconds = currentReadingTime;

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Book({
    required this.uid,
    this.photoURL,
    required this.name,
    this.authorName,
    required this.totalPageCount,
    this.currentPage,
    this.readerProgress,
    required this.createdAt,
    required this.updatedAt,
    required this.totalReadingTime,
    this.lastStartTime,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Book(
      uid: doc.id,
      photoURL: data['photo_url'] as String?,
      name: data['name'] as String? ?? '',
      authorName: data['author_name'] as String?,
      totalPageCount: data['total_page_count'] as int? ?? 1,
      currentPage: data['current_page'] as int? ?? 0,
      readerProgress: data['reader_progress'] as int?,
      createdAt: parseDateTime(data['created_at']),
      updatedAt: parseDateTime(data['updated_at']),
      totalReadingTime: data['total_reading_time'] ?? 0,
      lastStartTime: data['last_start_time'] != null
          ? parseDateTime(data['last_start_time'])
          : null,
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
      'current_page': currentPage,
      'reader_progress':
          (currentPage != null && totalPageCount != null && totalPageCount! > 0)
              ? ((currentPage! * 100) / totalPageCount!).round()
              : 0,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
      'last_start_time':
          lastStartTime != null ? Timestamp.fromDate(lastStartTime!) : null,
      'total_reading_time': totalReadingTime,
    };
  }
}
