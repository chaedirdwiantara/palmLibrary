import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:palm_library/models/book.dart';

class ApiService {
  static const String _baseUrl = 'http://gutendex.com/books';

  static Future<List<Book>> fetchBooks({int page = 1}) async {
    final response = await http.get(Uri.parse('$_baseUrl?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Book.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl?search=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Book.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to search books');
    }
  }
}
