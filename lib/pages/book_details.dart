import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final bool isFromSavedScreen = args.isFromSavedScreen;
    return Scaffold(
      appBar: AppBar(title: Text(book.title, style: theme.headlineSmall)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (book.imageLinks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.book);
                    },
                  ),
                ),
              Column(
                children: [
                  Text(book.title, style: theme.titleMedium),
                  Text(book.authors.join(', '), style: theme.labelMedium),
                  Text(
                    'Published: ${book.publishedDate}',
                    style: theme.bodySmall,
                  ),
                  Text('Page count: ${book.pageCount}', style: theme.bodySmall),
                  Text('Language ${book.language}', style: theme.bodySmall),
                  SizedBox(height: 10.0),

                  SizedBox(
                    child: !isFromSavedScreen
                        ? ElevatedButton.icon(
                            onPressed: () async {
                              //Save a book to the DB
                              try {
                                int savedInt = await DatabaseHelper.instance
                                    .insert(book);
                                SnackBar snackBar = SnackBar(
                                  content: Text('Book Saved $savedInt'),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              } catch (e) {
                                throw Exception(
                                  "Unable to save book ${e.toString()}",
                                );
                              }
                            },
                            icon: Icon(Icons.bookmark_add),
                            label: Text("Saved"),
                          )
                        : ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await DatabaseHelper.instance
                                    .toggleFavoriteStatus(
                                      book.id,
                                      book.isFavorite,
                                    );
                              } catch (e) {
                                throw Exception(
                                  "Unable to toggle favorite status ${e.toString()}",
                                );
                              }
                            },
                            icon: Icon(Icons.favorite),
                            label: Text("Favotite"),
                          ),
                  ),
                  // Row(
                  //   mainAxisAlignment: !isFromSavedScreen
                  //       ? MainAxisAlignment.spaceEvenly
                  //       : MainAxisAlignment.center,
                  //   children: [
                  //     !isFromSavedScreen
                  //         ? ElevatedButton.icon(
                  //             onPressed: () async {
                  //               //Save a book to the DB
                  //               try {
                  //                 int savedInt = await DatabaseHelper.instance
                  //                     .insert(book);
                  //                 SnackBar snackBar = SnackBar(
                  //                   content: Text('Book Saved $savedInt'),
                  //                 );
                  //                 ScaffoldMessenger.of(
                  //                   context,
                  //                 ).showSnackBar(snackBar);
                  //               } catch (e) {
                  //                 throw Exception(
                  //                   "Unable to save book ${e.toString()}",
                  //                 );
                  //               }
                  //             },
                  //             icon: Icon(Icons.bookmark_add),
                  //             label: Text("Saved"),
                  //           )
                  //         : const SizedBox.shrink(),
                  //     ElevatedButton.icon(
                  //       onPressed: () async {
                  //         try {
                  //           await DatabaseHelper.instance.toggleFavoriteStatus(
                  //             book.id,
                  //             book.isFavorite,
                  //           );
                  //         } catch (e) {
                  //           throw Exception(
                  //             "Unable to toggle favorite status ${e.toString()}",
                  //           );
                  //         }
                  //         // try {
                  //         //   await DatabaseHelper.instance.readAllBooks().then((
                  //         //     books,
                  //         //   ) {
                  //         //     for (var book in books) {
                  //         //       print("Title ${book.title}");
                  //         //     }
                  //         //   });
                  //         // } catch (e) {
                  //         //   print("Error database $e");
                  //         // }
                  //       },
                  //       icon: Icon(Icons.favorite),
                  //       label: Text("Favotite"),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(width: double.infinity, height: 10.0),
                  Text("Description", style: theme.titleMedium),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 30),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withValues(alpha: 0.3),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 0.5,
                      ),
                    ),
                    child: Text(book.description),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
