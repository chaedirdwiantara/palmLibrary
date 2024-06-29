import 'package:flutter/material.dart';
import 'package:palm_library/controllers/book_controller.dart';
import 'package:palm_library/widgets/search_bar.dart';
import 'package:palm_library/widgets/book_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Menyembunyikan tinggi AppBar
      ),
      body: Column(
        children: [
          SearchBar(searchController: _searchController),
          Expanded(child: BookList()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/liked-books');
          }
        },
      ),
    );
  }
}
