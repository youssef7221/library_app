part of 'search_books_cubit.dart';

abstract class SearchBooksState extends Equatable {
  const SearchBooksState();

  @override
  List<Object> get props => [];
}

class SearchBooksInitial extends SearchBooksState {}

class SearchBooksFailure extends SearchBooksState {
  final String errMessage;
  const SearchBooksFailure(this.errMessage);
}

class SearchBooksSuccess extends SearchBooksState {
  final List<BookModel> books;
  const SearchBooksSuccess(this.books);
}

class SearchBooksLoading extends SearchBooksState {}
