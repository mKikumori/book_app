import 'dart:async';
import 'package:book_app/services/book_service.dart';
import 'package:book_app/view_models/app/book_details_view_model.dart';
import 'package:book_app/widgets/background_widget.dart';
import 'package:book_app/widgets/info_row_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BookDetailsView extends StatefulWidget {
  final String uid;

  const BookDetailsView({super.key, required this.uid});

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  final BookService _bookService = BookService();
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void initState() {
    super.initState();

    /*_timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });*/
  }

  @override
  void dispose() {
    //_stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookDetailsViewModel>();

    return BackgroundWidget(
      child: Center(
        child: FutureBuilder(
          future: _bookService.getBook(widget.uid),
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

            WidgetsBinding.instance.addPostFrameCallback((_) {
              viewModel.initializeFromBook(book);

              /*if (viewModel.isReading) {
                _startTimer();
              }*/
            });

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/book-placeholder.png',
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  InfoRow(label: "Book Name", value: book.name ?? ''),
                  const SizedBox(height: 10),
                  InfoRow(label: "Author", value: book.authorName ?? ''),
                  const SizedBox(height: 10),
                  InfoRow(
                    label: "Pages",
                    value: (book.totalPageCount ?? 0).toString(),
                  ),
                  /*const SizedBox(height: 10),
                  Text(
                    book.formattedReadingTime,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  const SizedBox(height: 20),
                  CupertinoButton.filled(
                    child: Text(viewModel.isReading ? 'Stop' : 'Start'),
                    onPressed: () {
                      viewModel.toggleReading(book.uid);

                      /*if (viewModel.isReading) {
                        _startTimer();
                      } else {
                        _stopTimer();
                      }*/
                    },
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
