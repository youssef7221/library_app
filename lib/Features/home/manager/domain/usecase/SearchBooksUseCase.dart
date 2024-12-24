import 'package:dartz/dartz.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/book_model.dart';
import 'package:library_app/Features/home/manager/domain/repos/home_repo.dart';
import 'package:library_app/core/errors/failures.dart';

class SearchBooksUseCase{
 HomeRepo homeRepo;
 SearchBooksUseCase(this.homeRepo);

 Future<Either<Failure,List<BookModel>>> fetchSearchBooks(String book){
   return homeRepo.fetchSearchBooks(book: book);
 }
}