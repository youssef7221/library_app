import 'package:dartz/dartz.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/book_model.dart';
import 'package:library_app/core/errors/failures.dart';

abstract class HomeDs{
Future<Either<Failure,List<BookModel>>> fetchFeaturedBooks();
Future<Either<Failure,List<BookModel>>> fetchSearchBooks(String book);
Future<Either<Failure,List<BookModel>>> fetchSmallFeaturedBooks();
}