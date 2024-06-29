import 'package:flutter/material.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:palm_library/views/book_detail_screen.dart';
import 'package:palm_library/widgets/book_item.dart';
import 'package:provider/provider.dart';

class LikedBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookController = Provider.of<BookController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghilangkan back button
      ),
      body: bookController.likedBooks.isEmpty
          ? const Center(child: Text('No liked books yet'))
          : ListView.builder(
              itemCount: bookController.likedBooks.length,
              itemBuilder: (context, index) {
                final book = bookController.likedBooks[index];
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
