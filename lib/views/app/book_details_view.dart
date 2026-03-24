import 'package:flutter/cupertino.dart';

class BookDetailsView extends StatelessWidget {
  final dynamic uid;

  const BookDetailsView({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Text("Book Details View: $uid");
  }
}
