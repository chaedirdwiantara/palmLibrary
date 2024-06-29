import 'package:flutter/material.dart';
import 'package:palm_library/models/book.dart';
import 'package:provider/provider.dart';
import 'controllers/book_controller.dart';
import 'views/home_screen.dart';
import 'views/liked_books_screen.dart';
import 'views/book_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookController(),
      child: MaterialApp(
        title: 'Palm Library',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/liked-books': (context) => LikedBooksScreen(),
          '/book-detail': (context) => BookDetailScreen(
              book: ModalRoute.of(context)!.settings.arguments as Book),
        },
      ),
    );
  }
}
