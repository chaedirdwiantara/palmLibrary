import 'package:flutter/material.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:palm_library/views/home_screen.dart';
import 'package:palm_library/views/liked_books_screen.dart';
import 'package:palm_library/views/search_screen.dart';
import 'package:provider/provider.dart';

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
          '/search': (context) => SearchScreen(),
        },
      ),
    );
  }
}
