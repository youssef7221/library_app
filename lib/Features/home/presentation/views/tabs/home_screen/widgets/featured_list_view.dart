import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/book_model.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/utils/api_service.dart';
import 'package:library_app/core/utils/app_fonts.dart';
import 'package:library_app/core/widgets/custom_book_view.dart';
import 'package:library_app/core/widgets/custom_error_widget.dart';
import 'package:library_app/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedBooksListView extends StatelessWidget {
  const FeaturedBooksListView({
    required this.books,
    super.key});
  final List<BookModel> books;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder:(context, state) {
        if (state is FeaturedBooksLoading) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child:CustomLoadingIndicator());
        } else if (state is FeaturedBooksFailure) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child: CustomErrorWidget(errMessage: state.errMessage));
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            child: ListView.builder(
                itemCount:books.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomBookView(books: books[index], index: index),
                  );
                }),
          );
        }
      },
    );
  }
}
