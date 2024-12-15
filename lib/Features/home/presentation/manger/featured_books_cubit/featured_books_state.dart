part of 'featured_books_cubit.dart';

abstract class FeaturedBooksState extends Equatable {
  const FeaturedBooksState();

  @override
  List<Object> get props => [];
}

class FeaturedBooksInitial extends FeaturedBooksState {}

class FeaturedBooksLoading extends FeaturedBooksState {}

class FeaturedBooksFailure extends FeaturedBooksState {
  final String errMessage;

  const FeaturedBooksFailure(this.errMessage);
}

class FeaturedBooksSuccess extends FeaturedBooksState {}

class SmallFeaturedBooksLoading extends FeaturedBooksState {}

class SmallFeaturedBooksSuccess extends FeaturedBooksState {}

class FetchBookLoading extends FeaturedBooksState {}

class FetchBookSuccess extends FeaturedBooksState {}
