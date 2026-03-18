import 'package:flutter/cupertino.dart';

class BookWidget extends StatelessWidget {
  final String bookId;
  final String photoURL = '';
  final String bookName;
  final int totalPageNumber;

  const BookWidget(
      {super.key,
      required this.bookId,
      required this.bookName,
      required this.totalPageNumber});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
