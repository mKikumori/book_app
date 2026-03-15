import 'package:book_app/services/user_srevice.dart';
import 'package:book_app/views/app/home_view.dart';
import 'package:book_app/views/auth/register_view.dart';
import 'package:book_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  bool _isLoading = false;
  String? _uid;

  // Getters
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get password => _password;
  bool get isLoading => _isLoading;
  String? get uid => _uid;

  // Setters
  void setFirstName(String value) {
    _firstName = value;
  }

  void setLastName(String value) {
    _lastName = value;
  }

  void setEmail(String value) {
    _email = value;
  }

  void setPassword(String value) {
    _password = value;
  }

  void setUid(String value) {
    _uid = value;
  }

  void setUserData(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) {
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    notifyListeners();
  }

  // Loading Control
  void setLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> register({
    required String password,
    required BuildContext context,
  }) async {
    if (_email == null || _password == null) {
      // Handle error: email and password must not be null
      return;
    }

    setLoading(true);
    try {
      final credential = await _authService.register(_email!, password);

      _uid = credential?.user?.uid;

      await _userService.saveUserProfile(
        uid: _uid!,
        firstName: _firstName!,
        lastName: _lastName!,
        email: _email!,
      );

      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => HomeView()),
      );
      // Registration successful, you can perform additional actions here
    } on FirebaseAuthException catch (e) {
      // Handle registration errors here
      print('Registration error: ${e.message}');
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (_) => const RegisterView()),
        (route) => false,
      );
    } finally {
      setLoading(false);
    }
  }
}
