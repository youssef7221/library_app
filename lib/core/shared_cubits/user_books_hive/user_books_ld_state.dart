part of 'user_books_ld_cubit.dart';

@immutable
abstract class UserBooksLdState extends Equatable {
  final List<MyBookModelHive> bookModel;

  const UserBooksLdState({this.bookModel = const []});

  @override
  List<Object> get props => [bookModel];
}

final class UserBooksLdInitial extends UserBooksLdState {
  const UserBooksLdInitial() : super(bookModel:const []);
}

final class DeleteBookMarkedBook extends UserBooksLdState {
  const DeleteBookMarkedBook({required super.bookModel});
}

final class AddedBookMarkedBook extends UserBooksLdState {
  const AddedBookMarkedBook({required super.bookModel});
}

final class GetBooksSuccess extends UserBooksLdState {
  const GetBooksSuccess({required super.bookModel});
}

final class LoadingBooks extends UserBooksLdState {
  const LoadingBooks() : super();
}

final class UserBooksEmpty extends UserBooksLdState {
  const UserBooksEmpty() : super(bookModel:const []);
}
