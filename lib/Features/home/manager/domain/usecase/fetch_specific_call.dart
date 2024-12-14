import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/book_model/book_model.dart';
import '../repos/home_repo.dart';

class FetchSpecificCall{
  HomeRepo homeRepo;
  FetchSpecificCall(this.homeRepo);
  Future<Either<Failure, BookModel>>call(String bookId){
    return homeRepo.fetchSpecificBook(bookId: bookId);
  }
}