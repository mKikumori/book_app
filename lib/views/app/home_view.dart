import 'package:book_app/views/auth/login_view.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:book_app/services/auth_service.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();

  Future<void> signingOut(BuildContext context) async {
    try {
      await _authService.signOut();
      Navigator.of(context, rootNavigator: true).pushReplacement(
        CupertinoPageRoute(builder: (context) => const LoginView()),
      );
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Home'),
        ),
        child: Center(
          child: CustomButtonWidget(
              text: "Logout",
              width: MediaQuery.of(context).size.width * 0.8,
              onPressed: () async {
                await signingOut(context);
              }),
        ));
  }
}
