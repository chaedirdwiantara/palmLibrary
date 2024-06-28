import 'package:flutter/material.dart';
import 'package:palm_library/models/book.dart';

class BookItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookItem({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(book.imageUrl),
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: IconButton(
        icon: Icon(
          book.isLiked ? Icons.favorite : Icons.favorite_border,
          color: book.isLiked ? Colors.red : null,
        ),
        onPressed: () {
          book.isLiked = !book.isLiked;
        },
      ),
      onTap: onTap,
    );
  }
}
