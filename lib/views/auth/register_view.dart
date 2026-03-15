import 'package:book_app/views/auth/login_view.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
import 'package:book_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:book_app/widgets/background_widget.dart';
import 'package:book_app/view_models/auth/register_view_model.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);
    final nameController =
        TextEditingController(text: viewModel.firstName ?? '');
    final lastNameController =
        TextEditingController(text: viewModel.lastName ?? '');
    final emailController = TextEditingController(text: viewModel.email ?? '');
    final passwordController =
        TextEditingController(text: viewModel.password ?? '');

    return BackgroundWidget(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Register',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        CustomTextFieldWidget(
          text: 'First Name',
          controller: nameController,
          onChanged: viewModel.setFirstName,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWidget(
          controller: lastNameController,
          text: 'Last Name',
          onChanged: viewModel.setLastName,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWidget(
          controller: emailController,
          text: 'Email',
          onChanged: viewModel.setEmail,
        ),
        const SizedBox(height: 10),
        CustomTextPswfield(
          controller: passwordController,
          text: 'Password',
          onChanged: viewModel.setPassword,
        ),
        const SizedBox(height: 20),
        CustomButtonWidget(
          text: 'Continue',
          width: MediaQuery.of(context).size.width * 0.8,
          onPressed: () async {
            final name = nameController.text.trim();
            final lastName = lastNameController.text.trim();
            final email = emailController.text.trim();
            final password = passwordController.text.trim();
            final user =
                Provider.of<RegistrationViewModel>(context, listen: false);

            user.setUserData(
                firstName: name,
                lastName: lastName,
                email: email,
                password: password);

            await user.register(password: password, context: context);
          },
        ),
        const SizedBox(height: 12),
        CustomButtonWidget(
          text: 'I have an account',
          width: MediaQuery.of(context).size.width * 0.8,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => const LoginView()),
            );
          },
        ),
        if (viewModel.isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: CupertinoActivityIndicator(),
          ),
      ],
    )));
  }
}
