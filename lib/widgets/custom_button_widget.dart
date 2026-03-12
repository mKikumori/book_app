import 'package:flutter/cupertino.dart';

TextStyle _textStyle({
  Color color = CupertinoColors.white,
  double fontSize = 17,
  FontWeight fontWeight = FontWeight.w400,
  double height = 0.08,
  double letterSpacing = -0.43,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Widget? nextPage;
  final double width;
  final bool shouldPop;
  final bool accent;
  final VoidCallback? onPressed;

  void handleNavigation(BuildContext context,
      {Widget? nextPage, bool shouldPop = false}) {
    if (shouldPop) {
      Navigator.pop(context);
    } else if (nextPage != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => nextPage),
      );
    }
  }

  const CustomButtonWidget({
    super.key,
    required this.text,
    this.nextPage,
    required this.width,
    this.shouldPop = false,
    this.accent = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CupertinoButton.filled(
        onPressed: onPressed ??
            () => handleNavigation(context,
                nextPage: nextPage, shouldPop: shouldPop),
        padding: const EdgeInsets.symmetric(vertical: 12),
        borderRadius: BorderRadius.circular(8),
        child: Text(
          text,
          style: _textStyle(
            color: accent ? CupertinoColors.activeBlue : CupertinoColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
