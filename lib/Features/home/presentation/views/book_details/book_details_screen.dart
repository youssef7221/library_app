import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        children:[
          BackgroundBook(
              imgUrl: selectedBook.volumeInfo.imageLinks?.thumbnail ?? ""),
          Padding(
            padding: EdgeInsets.only(
              top: 40.h,
              left: 20.w,
              right: 20.w,
              bottom: 10.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BooksAppBar(
                    bookName: selectedBook.volumeInfo.title,
                    bookAuthor: selectedBook.volumeInfo.authors?.first),
                SizedBox(
                  height: 10.h,
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
                  height: 10.h,
                ),
                DetailsWidget(
                    rating: selectedBook.volumeInfo.averageRating,
                    category: selectedBook.volumeInfo.categories?.first,
                    pageCount: selectedBook.volumeInfo.pageCount),
                SizedBox(
                  height: 5.h,
                ),
                DescriptionWidget(
                    description: selectedBook.volumeInfo.description),
                SizedBox(
                  height: 10.h,
                ),
                BuyNowWidget(
                  selectedBook: selectedBook,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
