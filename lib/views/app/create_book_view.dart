import 'package:book_app/view_models/app/create_book_viewmodel.dart';
import 'package:book_app/views/app/home_view.dart';
import 'package:book_app/widgets/background_widget.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
import 'package:book_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CreateBookView extends StatelessWidget {
  const CreateBookView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreateBookViewmodel>(context, listen: false);
    return BackgroundWidget(
        child: Center(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // TODO: User upload book cover image
            },
            child: Image.asset(
              'assets/images/book-placeholder.png',
              width: 150,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
              text: 'Book Name:', controller: viewModel.bookNameController),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
              text: 'Author Name:', controller: viewModel.authorNameController),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
              text: 'Total Page Count:',
              controller: viewModel.totalPageCountController),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
              text: 'Current Page',
              controller: viewModel.currentPageController),
          const SizedBox(height: 20),
          CustomButtonWidget(
              text: 'CreateBook',
              width: MediaQuery.of(context).size.width * 0.8,
              onPressed: () async {
                final viewModel = context.read<CreateBookViewmodel>();

                await viewModel.createBook();

                if (!context.mounted) return;

                if (viewModel.statusMessage != null) {
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: Text(
                        'Book Creation ${viewModel.statusMessage!.contains('successful') ? 'Successful' : 'Failed'}',
                      ),
                      content: Text(viewModel.statusMessage!),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();

                            if (viewModel.statusMessage!
                                .contains('successful')) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    )));
  }
}
