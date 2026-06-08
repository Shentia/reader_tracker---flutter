import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getFavorites(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Book> favBooks = snapshot.data!;
            return ListView.builder(
              itemCount: favBooks.length,
              itemBuilder: (context, index) {
                Book book = favBooks[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      book.imageLinks['thumbnail'] ?? '',
                      fit: BoxFit.cover,
                    ),
                    title: Text(book.authors.join(', ')),
                    trailing: Icon(Icons.favorite, color: Colors.red),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No favorite books yet"));
          }
        }),
      ),
    );
  }
}
