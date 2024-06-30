import 'package:flutter/material.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const SearchBar({required this.searchController});

  @override
  Widget build(BuildContext context) {
    final bookController = Provider.of<BookController>(context, listen: false);

    void _searchBooks() {
      final query = searchController.text;
      if (query.isNotEmpty) {
        bookController.searchBooks(query);
      } else {
        bookController.clearSearch();
        bookController.fetchBooks();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search Books',
          border: const OutlineInputBorder(),
          isDense: true,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              searchController.clear();
              _searchBooks();
            },
          ),
        ),
        onChanged: (value) => _searchBooks(),
      ),
    );
  }
}
