import 'package:flutter/cupertino.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 1,
      color: const Color.fromARGB(60, 0, 0, 0),
    );
  }
}
