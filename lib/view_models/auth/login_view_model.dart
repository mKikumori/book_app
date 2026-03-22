import 'package:book_app/views/app/home_view.dart';
import 'package:book_app/views/auth/login_view.dart';
import 'package:book_app/widgets/custom_nav_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_app/services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _statusMessage;

  bool _isLoading = false;
  String? _email;
  String? _password;
  String? get statusMessage => _statusMessage;

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
      if (_authService.currentUser != null) {
        _statusMessage =
            'Login successful for ${_authService.currentUser!.email}!';
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (_) => const CustomNavBar()),
        );
      }
    } on FirebaseException catch (e) {
      _statusMessage = e.message ?? 'Something went wrong.';
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (_) => const LoginView()),
        (route) => false,
      );
    } catch (e) {
      _statusMessage = 'Unexpected error: $e';
    } finally {
      setLoading(false);
    }
  }
}
