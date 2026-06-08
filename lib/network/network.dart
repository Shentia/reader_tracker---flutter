import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:reader_tracker/models/book.dart';

class Network {
  // api endpoint

  static const String _baseUrl = "https://www.googleapis.com/books/v1/volumes";
  static String get apiKey => dotenv.env['BOOKS_API_KEY'] ?? "";

  Future<List<Book>> searchBooks(String query) async {
    var uri = Uri.parse('$_baseUrl?q=$query&key=$apiKey');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      //we have data (json)
      var data = json.decode(response.body);
      if (data['items'] != null && data['items'] is List) {
        List<Book> books = (data['items'] as List<dynamic>)
            .map((book) => Book.fromJson(book as Map<String, dynamic>))
            .toList();
        return books;
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load books");
    }
  }
}
