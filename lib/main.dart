import 'package:book_app/view_models/auth/login_view_model.dart';
import 'package:book_app/view_models/auth/psw_reset_view_model.dart';
import 'package:book_app/view_models/auth/register_view_model.dart';
import 'package:book_app/views/landing_view.dart';
import 'package:book_app/widgets/custom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
              ChangeNotifierProvider(create: (_) => LoginViewModel()),
              ChangeNotifierProvider(create: (_) => PasswordResetViewModel()),
            ],
            child: CupertinoApp(
                title: 'Book App',
                debugShowCheckedModeBanner: false,
                home: user == null ? const LandingView() : CustomNavBar()),
          );
        } else if (snapshot.hasError) {
          return const CupertinoApp(
            home: CupertinoPageScaffold(
              child: Center(
                child: Text("Firebase initialization failed"),
              ),
            ),
          );
        }
        return const CupertinoApp(
          home: CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      },
    );
  }
}
