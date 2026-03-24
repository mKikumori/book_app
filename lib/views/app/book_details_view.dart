import 'package:book_app/services/book_service.dart';
import 'package:book_app/widgets/background_widget.dart';
import 'package:book_app/widgets/info_row_widget.dart';
import 'package:flutter/cupertino.dart';

class BookDetailsView extends StatelessWidget {
  final String uid;
  final BookService _bookService = BookService();

  BookDetailsView({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Center(
        child: FutureBuilder(
          future: _bookService.getBook(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            }

            if (snapshot.hasError) {
              return const Text('Error loading book');
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Text('Book not found');
            }

            final book = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: upload image
                    },
                    child: Image.asset(
                      'assets/images/book-placeholder.png',
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InfoRow(label: "Book Name", value: book.name ?? ''),
                  const SizedBox(height: 10),
                  InfoRow(label: "Author Name", value: book.authorName ?? ''),
                  const SizedBox(height: 10),
                  InfoRow(label: "Description", value: book.description ?? ''),
                  const SizedBox(height: 10),
                  InfoRow(
                    label: "Total Page Count",
                    value: (book.totalPageCount ?? 0).toString(),
                  ),
                  const SizedBox(height: 10),
                  InfoRow(
                    label: "Current Page",
                    value: (book.currentPage ?? 0).toString(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
