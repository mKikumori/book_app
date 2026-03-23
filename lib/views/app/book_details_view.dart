import 'package:flutter/cupertino.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key, required uid});

  get uid => '';

  @override
  Widget build(BuildContext context) {
    return Text("Book Details View: $uid");
  }
}
