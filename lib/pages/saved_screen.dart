import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late Future<List<Book>> savedBooks;

  @override
  void initState() {
    super.initState();
    savedBooks = DatabaseHelper.instance.readAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Book>>(
        future: DatabaseHelper.instance.readAllBooks(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Book book = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: BookDetailsArguments(
                          itemBook: book,
                          isFromSavedScreen: true,
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(book.title),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            try {
                              await DatabaseHelper.instance.deleteBook(book.id);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Book deleted ${book.title}"),
                                ),
                              );
                            } catch (e) {
                              print("Error deleting book: $e");
                            }
                          },
                        ),
                        subtitle: Column(
                          children: [
                            Text(book.authors.join(", ")),
                            ElevatedButton.icon(
                              onPressed: () async {
                                //toggle the favorite flag
                                book.isFavorite = !book.isFavorite;
                                await DatabaseHelper.instance
                                    .toggleFavoriteStatus(
                                      book.id,
                                      book.isFavorite,
                                    );
                                setState(() {});
                              },

                              icon: Icon(
                                book.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: book.isFavorite ? Colors.red : null,
                              ),
                              label: Text(
                                book.isFavorite
                                    ? "Add to Favorites"
                                    : "Favorites",
                              ),
                            ),
                          ],
                        ),
                        leading: Image.network(
                          book.imageLinks['thumbnail'] ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.book);
                          },
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
