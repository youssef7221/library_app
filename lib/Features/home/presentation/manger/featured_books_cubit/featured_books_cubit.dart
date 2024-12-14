import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/Features/home/manager/domain/usecase/featured_books_use_case.dart';
import 'package:library_app/Features/home/manager/domain/usecase/small_featured_book_use_case.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import '../../../manager/data/models/book_model/book_model.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit() : super(FeaturedBooksInitial());
  final List<BookModel> featuredBooks = [];
  final List<BookModel> smallFeaturedBooks = [];

  final featuredBooksUseCase = getIt<FeaturedBooksUseCase>();
  final smallFeaturedBooksUseCase = getIt<SmallFeaturedBookUseCase>();

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    var result = await featuredBooksUseCase.call();
    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.errMessage));
      },
      (books) {
        featuredBooks.addAll(books);
        emit(FeaturedBooksSuccess());
      },
    );
  }

  Future<void> fetchSmallFeaturedBooks() async {
    emit(SmallFeaturedBooksLoading());
    var result = await smallFeaturedBooksUseCase.call();
    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.errMessage));
      },
      (books) {
        smallFeaturedBooks.addAll(books);
        emit(SmallFeaturedBooksSuccess());
      },
    );
  }
}
