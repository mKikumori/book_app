import 'package:book_app/views/auth/psw_recovery_view.dart';
import 'package:book_app/views/auth/register_view.dart';
import 'package:book_app/widgets/background_widget.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
import 'package:book_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:book_app/view_models/auth/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return BackgroundWidget(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Login',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        CustomTextFieldWidget(
          text: 'Email',
          controller: viewModel.emailController,
          onChanged: viewModel.setEmail,
        ),
        const SizedBox(height: 10),
        CustomTextPswfield(
          controller: viewModel.passwordController,
          text: 'Password',
          onChanged: viewModel.setPassword,
        ),
        const SizedBox(height: 20),
        CustomButtonWidget(
            text: "Continue",
            width: MediaQuery.of(context).size.width * 0.8,
            onPressed: () async {
              await viewModel.login(context);
            }),
        const SizedBox(height: 10),
        CustomButtonWidget(
          text: 'Create an account',
          width: MediaQuery.of(context).size.width * 0.8,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => const RegisterView()),
            );
          },
        ),
        /*const SizedBox(height: 10),
        CustomButtonWidget(
            text: "Forgot Password",
            width: MediaQuery.of(context).size.width * 0.8,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => const PswRecoveryView()),
              );
            }),*/
      ],
    )));
  }
}
