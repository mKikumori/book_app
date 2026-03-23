import 'package:book_app/models/book.dart';
import 'package:book_app/services/book_service.dart';
import 'package:book_app/views/auth/login_view.dart';
import 'package:book_app/widgets/background_widget.dart';
import 'package:book_app/widgets/book_widget.dart';
import 'package:book_app/widgets/custom_button_widget.dart';
import 'package:book_app/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_app/services/auth_service.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final BookService _bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HeaderWidget(),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to Book App",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<Book>>(
                    stream: _bookService.getBooks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CupertinoActivityIndicator();
                      }

                      if (snapshot.hasError) {
                        return const Text("Erro ao carregar livros");
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text("Nenhum livro encontrado");
                      }

                      final books = snapshot.data!;

                      return Column(
                        children: books.map((book) {
                          return BookWidget(book: book);
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButtonWidget(
                    text: "Logout",
                    width: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () async {
                      await AuthService().signOut();
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
