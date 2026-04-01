import 'package:book_app/models/book.dart';
import 'package:book_app/services/book_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookDetailsViewModel extends ChangeNotifier {
  bool _isReading = false;
  bool get isReading => _isReading;

  DateTime? _startTime;
  final BookService _bookService = BookService();

  void startReading(String uid) {
    _isReading = true;
    _startTime = DateTime.now();

    _bookService.updateBookField(uid, {
      'last_start_time': Timestamp.fromDate(_startTime!),
    });

    notifyListeners();
  }

  void stopReading(String uid) {
    if (_startTime != null) {
      final seconds = DateTime.now().difference(_startTime!).inSeconds;

      _bookService.updateBookField(uid, {
        'total_reading_time': FieldValue.increment(seconds),
        'last_start_time': null,
      });
    }

    _isReading = false;
    _startTime = null;
    notifyListeners();
  }

  void toggleReading(String uid) {
    if (_isReading) {
      stopReading(uid);
    } else {
      startReading(uid);
    }
  }

  void initializeFromBook(Book book) {
    if (book.lastStartTime != null) {
      _startTime = book.lastStartTime;
      _isReading = true;
    } else {
      _isReading = false;
    }

    notifyListeners();
  }
}
