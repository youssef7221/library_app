import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_app/Features/home/manager/domain/usecase/SearchBooksUseCase.dart';
import 'package:library_app/core/service_locator/service_locator.dart';

import '../../../manager/data/models/book_model/book_model.dart';
import '../../../manager/domain/repos/home_repo.dart';


part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit() : super(SearchBooksInitial());
   SearchBooksUseCase searchBooksUseCase = getIt<SearchBooksUseCase>();
   TextEditingController searchController = TextEditingController();
  Future<void> fetchSearchBooks({required String book}) async {
    emit(SearchBooksLoading());
    var result = await searchBooksUseCase.fetchSearchBooks(book);
    result.fold((failure) {
      emit(SearchBooksFailure(failure.errMessage));
    }, (books) {
      emit(SearchBooksSuccess(books));
    });
  }
}
