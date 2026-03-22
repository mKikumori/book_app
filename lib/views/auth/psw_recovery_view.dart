import 'package:book_app/view_models/auth/psw_reset_view_model.dart';
import 'package:book_app/widgets/background_widget.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
import 'package:book_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PswRecoveryView extends StatelessWidget {
  const PswRecoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PasswordResetViewModel>(context);
    final width = MediaQuery.of(context).size.width * 0.8;

    return BackgroundWidget(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Forgot your password?',
                style: TextStyle(fontSize: 22, color: CupertinoColors.white),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Enter your email and we’ll send you a reset link.',
                  style: TextStyle(fontSize: 17, color: CupertinoColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextFieldWidget(
                text: "Email",
                controller: model.emailController,
                onChanged: model.setEmail,
              ),
              const SizedBox(height: 24),
              CustomButtonWidget(
                text: 'Send Reset Link',
                width: width,
                onPressed: () async {
                  final success = await model.sendResetEmail();

                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: Text(success ? 'Success' : 'Error'),
                      content: Text(model.statusMessage ?? ''),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              CustomButtonWidget(
                text: 'Go Back',
                width: width,
                shouldPop: true,
              ),
              if (model.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CupertinoActivityIndicator(),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
