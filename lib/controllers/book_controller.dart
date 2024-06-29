import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:palm_library/models/book.dart';
import 'package:palm_library/services/api_service.dart';

class BookController extends ChangeNotifier {
  List<Book> _books = [];
  List<Book> _searchResults = [];
  bool _isLoading = false;
  int _page = 1;

  List<Book> get books => _searchResults.isNotEmpty ? _searchResults : _books;
  bool get isLoading => _isLoading;

  BookController() {
    _loadLikedBooks();
  }

  Future<void> _loadLikedBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedBooks = prefs.getStringList('likedBooks') ?? [];
    for (var book in _books) {
      book.isLiked = likedBooks.contains(book.id.toString());
    }
    notifyListeners();
  }

  Future<void> _saveLikedBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> likedBooks = _books
        .where((book) => book.isLiked)
        .map((book) => book.id.toString())
        .toList();
    prefs.setStringList('likedBooks', likedBooks);
  }

  void fetchBooks() async {
    _isLoading = true;
    notifyListeners();
    _books = await ApiService.fetchBooks(page: _page);
    await _loadLikedBooks();
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
    await _loadLikedBooks();
    _isLoading = false;
    notifyListeners();
  }

  void searchBooks(String query) async {
    _isLoading = true;
    notifyListeners();
    _searchResults = await ApiService.searchBooks(query);
    await _loadLikedBooks();
    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }

  void likeBook(Book book) {
    book.isLiked = !book.isLiked;
    _saveLikedBooks();
    notifyListeners();
  }

  List<Book> get likedBooks => _books.where((book) => book.isLiked).toList();
}
