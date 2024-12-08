import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/book_model.dart';
import 'package:library_app/Features/home/presentation/views/book_details/widgets/background_book.dart';
import 'package:library_app/Features/home/presentation/views/book_details/widgets/books_app_bar.dart';
import 'package:library_app/Features/home/presentation/views/book_details/widgets/buy_now_widget.dart';
import 'package:library_app/Features/home/presentation/views/book_details/widgets/description_widget.dart';
import 'package:library_app/Features/home/presentation/views/book_details/widgets/details_widget.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({required this.selectedBook, super.key});

  final BookModel selectedBook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundBook(
              imgUrl: selectedBook.volumeInfo.imageLinks?.thumbnail ?? ""),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BooksAppBar(
                    bookName: selectedBook.volumeInfo.title,
                    bookAuthor: selectedBook.volumeInfo.authors?.first),
                const SizedBox(
                  height: 10,
                ),
                Hero(
                    tag: "thumbnail${selectedBook.id}",
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.height * .35,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          selectedBook.volumeInfo.imageLinks?.thumbnail ?? "",
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                DetailsWidget(
                    rating: selectedBook.volumeInfo.averageRating,
                    category: selectedBook.volumeInfo.categories?.first,
                    pageCount: selectedBook.volumeInfo.pageCount),
                SizedBox(
                  height: 10,
                ),
                DescriptionWidget(
                    description: selectedBook.volumeInfo.description),
                SizedBox(
                  height: 10,
                ),
                BuyNowWidget(
                    price: selectedBook.saleInfo?.listPrice?.amount?.truncate())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
