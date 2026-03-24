import 'package:flutter/cupertino.dart';

class CustomCardContainer extends StatelessWidget {
  final Widget child;

  const CustomCardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.symmetric(horizontal: 35),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(150, 147, 150, 150),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
