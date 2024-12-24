import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/auth_firebase/auth_firebase.dart';
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
  final authService = getIt<AuthFirebase>();
  UserModel? userModel;

  Future<void> loadUser() async {
    try {
      emit(UserLoading());
      userModel = await _storage.readData("user");
      if (userModel != null) {
        emit(UserLoaded());
        loadFavouriteBooks();
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
      authService.signOut();
      emit(UserDeleted());
    } catch(e){
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
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(UserError("There is No Internet connection"));
        return;
      } else if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        final user = await fireBaseService.readUser(userModel?.id);
        ownedBooks = await Future.wait(
          user!.books!.map((bookId) async {
            await context.read<FeaturedBooksCubit>().fetchSpecificBook(bookId);
            return context.read<FeaturedBooksCubit>().bookModel;
          }).toList(),
        );
        emit(GetOwnedBooksSuccess());
        if (user.books!.isEmpty) {
          emit(UserOwnedBooksEmpty());
        }
      }
    } catch (e) {
      emit(UserError("Failed to load owned books: ${e.toString()}"));
    }
  }
//-----------------------------------------
  final hiveService = getIt<HiveService>();
  final storage = getIt<SecureStorageManager>();
  List<MyBookModelHive> favouritesBooks = [];
  bool isBookBookmarked(String? bookId) {
    return favouritesBooks.any((book) => book.id == bookId);
  }
  void toggleBookBookmark(BookModel? selectedBook) {
    if (selectedBook == null) return;

    final isAlreadyBookmarked = isBookBookmarked(selectedBook.id);

    if (isAlreadyBookmarked) {
       deleteBook(selectedBook.id, userModel?.id);
    } else {
       saveBook(selectedBook, userModel?.id);
    }
  }

  void deleteBook(String? selectedBookId, String? userId) async {
    await hiveService.deleteBook(userId, selectedBookId);
    final afterDelete =
    favouritesBooks.where((book) => book.id != selectedBookId).toList();
    favouritesBooks = afterDelete;
    if (favouritesBooks.isNotEmpty) {
      emit(DeleteBookMarkedBook(bookId: selectedBookId));
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
      emit(AddedBookMarkedBook(bookId:selectedBook.id));
    } catch (e) {
      emit(UserError("Failed to save book: ${e.toString()}"));
    }
  }
  Future<void> loadFavouriteBooks() async {
    try {
      favouritesBooks = await hiveService.getBooks(userModel?.id);
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
