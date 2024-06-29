import 'package:flutter/material.dart';
import 'package:palm_library/models/book.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:provider/provider.dart';

class BookItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookItem({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bookController = Provider.of<BookController>(context, listen: false);

    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: Image.network(
        book.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(
        book.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        book.author,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(
          book.isLiked ? Icons.favorite : Icons.favorite_border,
          color: book.isLiked ? Colors.red : null,
        ),
        onPressed: () {
          bookController.likeBook(book);
        },
      ),
      onTap: onTap,
    );
  }
}
