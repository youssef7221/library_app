import 'package:library_app/Features/home/manager/data/data_source/home_ds.dart';
import 'package:library_app/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:library_app/core/errors/failures.dart';
import 'package:dio/dio.dart';

import '../models/book_model/book_model.dart';
import '../../domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDs homeDs;
  HomeRepoImpl(this.homeDs);
  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() {
   return homeDs.fetchFeaturedBooks(); 
  }
  @override
  Future<Either<Failure, List<BookModel>>> fetchSmallFeaturedBooks() {
  return homeDs.fetchSmallFeaturedBooks();
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks({required String book}) {
  return homeDs.fetchSearchBooks(book);
  }

  @override
  Future<Either<Failure, BookModel>> fetchSpecificBook({required String bookId}) {
    return homeDs.fetchSpecificBook(bookId);
  }

  
  
}
