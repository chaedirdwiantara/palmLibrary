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
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 6.0, right: 6.0),
        child: Column(
          children: [
            SearchBar(searchController: _searchController),
            Expanded(child: BookList()),
          ],
        ),
      ),
    );
  }
}
