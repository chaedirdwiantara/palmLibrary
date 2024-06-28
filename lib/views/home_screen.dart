import 'package:flutter/material.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:palm_library/views/book_detail_screen.dart';
import 'package:palm_library/widgets/book_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final bookController =
          Provider.of<BookController>(context, listen: false);
      bookController.fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookController = Provider.of<BookController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gutenberg Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/liked-books');
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !bookController.isLoading) {
            bookController.loadMoreBooks();
          }
          return false;
        },
        child: bookController.isLoading && bookController.books.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: bookController.books.length + 1,
                itemBuilder: (context, index) {
                  if (index == bookController.books.length) {
                    return bookController.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox();
                  }
                  final book = bookController.books[index];
                  return BookItem(
                    book: book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
