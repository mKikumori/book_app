import 'package:book_app/views/auth/login_view.dart';
import 'package:book_app/views/auth/register_view.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
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

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Book App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            CustomButtonWidget(
              text: 'Login',
              nextPage: const LoginView(),
              width: 200.0,
            ),
            SizedBox(height: 8),
            CustomButtonWidget(
              text: 'Register',
              nextPage: const RegisterView(),
              width: 200.0,
            )
          ],
        ),
      ),
    );
  }
}
