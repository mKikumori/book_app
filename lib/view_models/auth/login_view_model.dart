import 'package:book_app/views/app/home_view.dart';
import 'package:book_app/views/auth/login_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_app/services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;
  bool get isLoading => _isLoading;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    if (_email == null || _password == null) return;
    setLoading(true);
    try {
      await _authService.signIn(email: _email!, password: _password!);
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => HomeView()),
      );
    } on FirebaseException catch (e) {
      // Handle login error (e.g., show a message to the user)
      print('Login error: ${e.message}');
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (_) => const LoginView()),
        (route) => false,
      );
    } finally {
      setLoading(false);
    }
  }
}
