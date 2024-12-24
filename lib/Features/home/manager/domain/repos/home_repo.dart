import 'package:library_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/book_model/book_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookModel>>> fetchSmallFeaturedBooks();

  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks();

  Future<Either<Failure, List<BookModel>>> fetchSearchBooks(
      {required String book});

  Future<Either<Failure, BookModel>> fetchSpecificBook(
      {required String? bookId});
}
