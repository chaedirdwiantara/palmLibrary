import 'package:flutter/material.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:palm_library/widgets/book_item.dart';
import 'package:palm_library/views/book_detail_screen.dart';
import 'package:provider/provider.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookController = Provider.of<BookController>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !bookController.isLoading &&
            bookController.books.isNotEmpty) {
          bookController.loadMoreBooks();
        }
        return false;
      },
      child: bookController.isLoading && bookController.books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : bookController.books.isEmpty
              ? const Center(child: Text('No books found'))
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
    );
  }
}
