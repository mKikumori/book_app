import 'package:flutter/cupertino.dart';

class BookWidget extends StatelessWidget {
  final dynamic book;

  const BookWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 90,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey4,
              borderRadius: BorderRadius.circular(8),
              image: book.photoURL != null && book.photoURL.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(book.photoURL),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage('assets/images/book-placeholder.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Pages: ${book.totalPageCount}",
                  style: const TextStyle(
                      fontSize: 14, color: CupertinoColors.systemGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
