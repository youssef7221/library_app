import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/firebase_service/firebase_service.dart';
import 'package:library_app/core/flutter_secure/flutter_secure.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/shared_cubits/user_cubit/user_state.dart';
import '../../../Features/home/manager/data/models/book_model/book_model.dart';
import '../../book_model/MyBookModelHive.dart';
import '../../hive_service/hive_service.dart';
import '../../utils/model/userdm.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  List<BookModel> ownedBooks = [];
  final _storage = getIt<SecureStorageManager>();
  final fireBaseService = getIt<FirebaseService>();
  UserModel? userModel;

  Future<void> loadUser() async {
    try {
      emit(UserLoading());
      userModel = await _storage.readData("user");
      if (userModel != null) {
        emit(UserLoaded());
      } else {
        emit(UserError("User not found"));
      }
    } catch (e) {
      emit(UserError("Failed to load user"));
    }
  }

  Future<void> updateUser(UserModel newUser) async {
    try {
      await _storage.saveData("user", newUser);
      userModel = newUser;
      emit(UserLoaded());
    } catch (e) {
      emit(UserError("Failed to update user"));
    }
  }

  Future<void> deleteUser() async {
    try {
      emit(UserLoading());
      await _storage.deleteData("user");
      userModel = null;
      emit(UserDeleted());
    } catch (e) {
      emit(UserError("Failed to load user"));
    }
  }

  Future<void> addBookToUser(String? userId, String? bookId) async {
    await fireBaseService.addBookToUser(userId, bookId, (error) {
      error.toString();
    });
    emit(AddBookSuccess());
  }

  Future<void> loadOwnedBooks(BuildContext context) async {
    try {
      emit(LoadingBooks());
      final user = await fireBaseService.readUser(userModel?.id);
      if (user == null || user.books == null || user.books!.isEmpty){
        emit(UserError("There is No Internet connection"));
        return;
      }
      ownedBooks = await Future.wait(
        user.books!.map((bookId) async {
          await context.read<FeaturedBooksCubit>().fetchSpecificBook(bookId);
          return context.read<FeaturedBooksCubit>().bookModel;
        }).toList(),
      );
      emit(GetOwnedBooksSuccess());
      if (user.books!.isEmpty) {
        emit(UserOwnedBooksEmpty());
      }
    }catch(e){
      emit(UserError("Failed to load owned books: ${e.toString()}"));
    }
  }

  //-----------------------------------------
  final hiveService = getIt<HiveService>();
  final storage = getIt<SecureStorageManager>();
  bool isBookMarked = false;
  List<MyBookModelHive> favouritesBooks = [];

  void deleteBook(String? selectedBookId, String? userId) async {
    await hiveService.deleteBook(userId, selectedBookId);
    final afterDelete =
        favouritesBooks.where((book) => book.id != selectedBookId).toList();
    favouritesBooks = afterDelete;
    isBookMarked = false;
    if (favouritesBooks.isNotEmpty) {
      emit(DeleteBookMarkedBook());
    } else {
      emit(UserFavouriteBooksEmpty());
    }
  }

  void saveBook(BookModel? selectedBook, String? userModelId) async {
    try {
      final currentBooks =
          favouritesBooks.where((book) => book.id != selectedBook?.id).toList();
      await hiveService.saveBook(userModelId, selectedBook!);
      final updatedBooks = [
        ...currentBooks,
        MyBookModelHive.fromBookModel(selectedBook)
      ];
      favouritesBooks = updatedBooks;
      isBookMarked = true;
      emit(AddedBookMarkedBook());
    } catch (e) {
      emit(UserError("Failed to save book: ${e.toString()}"));
    }
  }

  Future<void> loadFavouriteBooks() async {
    try {
      favouritesBooks = hiveService.getBooks(userModel?.id);
      if (favouritesBooks.isNotEmpty) {
        emit(GetFavouriteBooksSuccess());
      } else {
        emit(UserFavouriteBooksEmpty());
      }
    } catch (e) {
      emit(UserError("Failed to load favourite books: ${e.toString()}"));
    }
  }
}
