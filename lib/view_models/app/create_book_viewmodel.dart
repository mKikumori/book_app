import 'package:book_app/services/auth_service.dart';
import 'package:book_app/services/book_service.dart';
import 'package:flutter/cupertino.dart';

class CreateBookViewmodel extends ChangeNotifier {
  final BookService _bookService = BookService();
  final AuthService _authService = AuthService();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController totalPageCountController =
      TextEditingController();
  final TextEditingController currentPageController = TextEditingController();
  String? _statusMessage;

  bool _isLoading = false;
  String? get statusMessage => _statusMessage;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  @override
  void dispose() {
    bookNameController.dispose();
    authorNameController.dispose();
    descriptionController.dispose();
    totalPageCountController.dispose();
    currentPageController.dispose();
    super.dispose();
  }

  Future<void> createBook() async {
    final name = bookNameController.text;
    final author = authorNameController.text;
    final description = descriptionController.text;
    final totalPages = int.tryParse(totalPageCountController.text);
    final currentPage = int.tryParse(currentPageController.text);

    if (name.isEmpty ||
        author.isEmpty ||
        description.isEmpty ||
        totalPages == null ||
        totalPages != int.parse(totalPageCountController.text) ||
        currentPage == null ||
        currentPage != int.parse(currentPageController.text) ||
        currentPage > totalPages) {
      _statusMessage = "Please fill all fields correctly";
      notifyListeners();
      return;
    }

    setLoading(true);
    try {
      await _bookService.saveNewBook(
        name: name,
        totalPageCount: totalPages,
        authorName: author,
        description: description,
        currentPage: currentPage,
        userId: _authService.currentUser!.uid,
      );

      _statusMessage = 'Book creation was successful!';
    } catch (e, stack) {
      print("CREATE BOOK ERROR: $e");
      print(stack);
      _statusMessage = 'Failed to create book: $e';
    } finally {
      setLoading(false);
    }
  }
}
