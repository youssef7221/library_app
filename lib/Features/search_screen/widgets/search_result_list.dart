import 'package:flutter/material.dart';
import 'package:library_app/core/widgets/custom_book_view.dart';

import '../../home/manager/data/models/book_model/book_model.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({required this.books,super.key});
  final List<BookModel>? books;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1/2,mainAxisSpacing: 20),
      padding: EdgeInsets.zero,
      itemCount: books?.length??0,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: CustomBookView(books: books?[index], index: index,width: 300,)
        );
      },
    );
  }
}
