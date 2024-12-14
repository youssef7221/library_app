import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../Features/home/manager/data/models/book_model/book_model.dart';
import '../../book_model/MyBookModelHive.dart';
import '../../flutter_secure/flutter_secure.dart';
import '../../hive_service/hive_service.dart';
import '../../service_locator/service_locator.dart';

part 'user_books_ld_state.dart';

class UserBooksLdCubit extends Cubit<UserBooksLdState> {
  UserBooksLdCubit() : super(const UserBooksLdInitial());

  final hiveService = getIt<HiveService>();
  final storage = getIt<SecureStorageManager>();
  bool isBookMarked = false;

  void deleteBook(String? selectedBookId, String? userId) async {
    final currentBooks = state.bookModel;
    await hiveService.deleteBook(userId, selectedBookId);
    final updatedBooks =
        currentBooks.where((book) => book.id != selectedBookId).toList();
    isBookMarked = false;
    emit(DeleteBookMarkedBook(bookModel: updatedBooks));
  }

  void saveBook(BookModel? selectedBook, String? userModelId) async {
    final currentBooks = state.bookModel;
    await hiveService.saveBook(userModelId, selectedBook!);
    final updatedBooks = [
      ...currentBooks,
      MyBookModelHive.fromBookModel(selectedBook)
    ];
    isBookMarked = true;
    emit(AddedBookMarkedBook(bookModel: updatedBooks));
  }

  void loadBooks(String? userModelId) {
    final books = hiveService.getBooks(userModelId);
    if (books.isNotEmpty) {
      emit(GetBooksSuccess(bookModel: books));
    } else {
      emit(const UserBooksEmpty());
    }
  }
}
