import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/image_links.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/volume_info.dart';
import 'package:library_app/Features/home/manager/domain/usecase/featured_books_use_case.dart';
import 'package:library_app/Features/home/manager/domain/usecase/small_featured_book_use_case.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import '../../../manager/data/models/book_model/book_model.dart';
import '../../../manager/domain/usecase/fetch_specific_call.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit() : super(FeaturedBooksInitial());
  final List<BookModel> featuredBooks = [];
  final List<BookModel> smallFeaturedBooks = [];
  BookModel bookModel = BookModel(
      volumeInfo: VolumeInfo(
          imageLinks: ImageLinks(smallThumbnail: "", thumbnail: "")));
  final featuredBooksUseCase = getIt<FeaturedBooksUseCase>();
  final smallFeaturedBooksUseCase = getIt<SmallFeaturedBookUseCase>();
  final fetchSpecificCall = getIt<FetchSpecificCall>();

  Future<void> fetchFeaturedBooks() async {
    featuredBooks.clear();
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
    emit(FeaturedBooksLoading());
    smallFeaturedBooks.clear();
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

  Future<void> fetchSpecificBook(String? bookId) async {
    emit(FetchBookLoading());
    var result = await fetchSpecificCall.call(bookId);
    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.errMessage));
      },
      (book) {
        bookModel = book;
        emit(FetchBookSuccess());
      },
    );
  }
}
