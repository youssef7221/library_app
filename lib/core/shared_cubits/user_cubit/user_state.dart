import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../book_model/MyBookModelHive.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserDeleted extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteBookMarkedBook extends UserState {
  final String? bookId;

  const DeleteBookMarkedBook({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class AddedBookMarkedBook extends UserState {
  final String? bookId;

  const AddedBookMarkedBook({required this.bookId});

  @override
  List<Object?> get props => [bookId];
}

class BookMarkedUpdated extends UserState {}

class GetFavouriteBooksSuccess extends UserState {}

class LoadingBooks extends UserState {}

class UserFavouriteBooksEmpty extends UserState {}

class GetOwnedBooksSuccess extends UserState {}

class UserOwnedBooksEmpty extends UserState {}

class AddBookSuccess extends UserState {}
