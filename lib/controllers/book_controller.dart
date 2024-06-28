import 'package:flutter/material.dart';
import 'package:palm_library/models/book.dart';
import 'package:palm_library/services/api_service.dart';

class BookController extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> _searchResults = [];
  bool _isLoading = false;
  int _page = 1;

  List<Book> get books => _books;
  List<Book> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  void fetchBooks() async {
    _isLoading = true;
    notifyListeners();
    _books = await ApiService.fetchBooks(page: _page);
    _isLoading = false;
    notifyListeners();
  }

  void loadMoreBooks() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    _page++;
    final moreBooks = await ApiService.fetchBooks(page: _page);
    _books.addAll(moreBooks);
    _isLoading = false;
    notifyListeners();
  }

  void searchBooks(String query) async {
    _isLoading = true;
    notifyListeners();
    _searchResults = await ApiService.searchBooks(query);
    _isLoading = false;
    notifyListeners();
  }

  void likeBook(Book book) {
    book.isLiked = !book.isLiked;
    notifyListeners();
  }

  List<Book> get likedBooks => _books.where((book) => book.isLiked).toList();
}
