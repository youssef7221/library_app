import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../book_model/MyBookModelHive.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserDeleted extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

final class DeleteBookMarkedBook extends UserState {}

final class AddedBookMarkedBook extends UserState {}

final class GetFavouriteBooksSuccess extends UserState {}

final class LoadingBooks extends UserState {}

final class UserFavouriteBooksEmpty extends UserState {}

final class GetOwnedBooksSuccess extends UserState {}

final class UserOwnedBooksEmpty extends UserState {}

final class AddBookSuccess extends UserState {}
