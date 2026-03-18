import 'package:book_app/views/auth/login_view.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_app/services/auth_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Home'),
        ),
        child: Center(
            child: Column(
          children: [],
        )));
  }
}
