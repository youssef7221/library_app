import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../data/models/book_model/book_model.dart';
import '../repos/home_repo.dart';

class FeaturedBooksUseCase{
  HomeRepo homeRepo;
  FeaturedBooksUseCase(this.homeRepo);
  Future<Either<Failure, List<BookModel>>>call(){
    return homeRepo.fetchFeaturedBooks();
  }
}