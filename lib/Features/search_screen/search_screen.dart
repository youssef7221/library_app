import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/search_screen/widgets/search_result_list.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/widgets/custom_loading_indicator.dart';
import '../home/presentation/manger/search_books_cubit/search_books_cubit.dart';
import 'widgets/custom_search_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<SearchBooksCubit>(),
        child: BlocBuilder<SearchBooksCubit, SearchBooksState>(
          builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchTextField(),
                    SizedBox(
                      height: 16,
                    ),
                    if (state is SearchBooksSuccess)
                    Expanded(
                      child:SearchResultListView(books: state.books),
                    ),
                    if (state is SearchBooksLoading)
                      CustomLoadingIndicator()
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}

