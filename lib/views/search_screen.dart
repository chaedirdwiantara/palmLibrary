import 'package:flutter/material.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:palm_library/views/book_detail_screen.dart';
import 'package:palm_library/widgets/book_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _searchBooks(BookController bookController) {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      bookController.searchBooks(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookController = Provider.of<BookController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchBooks(bookController),
                ),
              ),
              onSubmitted: (_) => _searchBooks(bookController),
            ),
          ),
          Expanded(
            child: bookController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: bookController.searchResults.length,
                    itemBuilder: (context, index) {
                      final book = bookController.searchResults[index];
                      return BookItem(
                        book: book,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailScreen(book: book),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
