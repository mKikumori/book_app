import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService([FirebaseAuth? auth]) : _auth = auth ?? FirebaseAuth.instance;

  /// Register without verification
  Future<UserCredential?> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User registered: ${userCredential.user?.uid}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Registration error: ${e.code} - ${e.message}");
      return null;
    }
  }

  /// User sign in
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Sign-in error: ${e.code} - ${e.message}");
      return null;
    }
  }

  /// Password reset
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent to $email");
      return true;
    } on FirebaseAuthException catch (e) {
      print("Failed to send password reset email: ${e.code} - ${e.message}");
      return false;
    } catch (e) {
      print("Unexpected error: $e");
      return false;
    }
  }

  /// Getter
  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async => await _auth.signOut();
}
