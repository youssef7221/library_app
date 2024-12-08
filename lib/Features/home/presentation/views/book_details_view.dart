import 'package:library_app/Features/home/presentation/manger/smila_books_cubit/search_books_cubit.dart';
import 'package:library_app/Features/home/presentation/views/widgets/book_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/data/models/book_model/book_model.dart';
import '../manger/search_books_cubit/search_books_cubit.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({super.key, required this.bookModel});

  final BookModel bookModel;
  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  void initState() {
    BlocProvider.of<SearchBooksCubit>(context).fetchSearchBooks(
        book: widget.bookModel.volumeInfo.categories![0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: BookDetailsViewBody(
      //     bookModel: widget.bookModel,
      //   ),
      // ),
    );
  }
}
