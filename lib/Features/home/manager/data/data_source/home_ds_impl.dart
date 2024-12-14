import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:library_app/Features/home/manager/data/data_source/home_ds.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/book_model.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/volume_info.dart';
import 'package:library_app/core/errors/failures.dart';
import 'package:library_app/core/utils/api_service.dart';

class HomeDsImpl extends HomeDs {
  ApiService apiService;

  HomeDsImpl(this.apiService);

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    const int maxResultsPerRequest = 20;
    int startIndex = 0;
    bool hasMore = true;
    List<BookModel> allBooks = [];
    try {
      while (hasMore) {
        final data = await apiService.get(
          endPoint: 'volumes?Filtering=free-ebooks&q=programming&startIndex='
              '$startIndex&maxResults=$maxResultsPerRequest&orderBy=newest',
        );
        if (data['items'] != null) {
          // Add fetched items to the list
          List<BookModel> books = (data['items'] as List<dynamic>)
              .map((item) => BookModel.fromJson(item))
              .where((item) => item.volumeInfo.pageCount! > 0)
              .toList();
          allBooks.addAll(books);
          // Check if there are more items to fetch
          startIndex += maxResultsPerRequest;
          hasMore = startIndex < (20);
        } else {
          hasMore = false; // No more items
        }
      }
      return right(allBooks);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }


  @override
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks(String book) async {
    const int maxResultsPerRequest = 20;
    int startIndex = 0;
    bool hasMore = true;
    List<BookModel> allBooks = [];
    try {
      while (hasMore) {
        final data = await apiService.get(
          endPoint: 'volumes?Filtering=ebooks&q=$book+intitle&startIndex='
              '$startIndex&maxResults=$maxResultsPerRequest',
        );
        if (data['items'] != null) {
          List<BookModel> books = (data['items'] as List<dynamic>)
              .map((item) => BookModel.fromJson(item))
              .toList();
          allBooks.addAll(books);
          startIndex += maxResultsPerRequest;
          hasMore = startIndex < (60);
        } else {
          hasMore = false; // No more items
        }
      }
      return right(allBooks);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSmallFeaturedBooks() async {
    const int maxResultsPerRequest = 20;
    int startIndex = 0;
    bool hasMore = true;
    List<BookModel> allBooks = [];
    try {
      while (hasMore) {
        final data = await apiService.get(
          endPoint: 'volumes?Filtering=free-ebooks&q=story&startIndex='
              '$startIndex&maxResults=$maxResultsPerRequest&orderBy=newest',
        );
        if (data['items'] != null) {
          List<BookModel> books = (data['items'] as List<dynamic>)
              .map((item) => BookModel.fromJson(item))
              .where((item) =>
                  item.volumeInfo.pageCount! <= 200 &&
                  item.volumeInfo.pageCount! > 0)
              .toList();
          allBooks.addAll(books);
          // Check if there are more items to fetch
          startIndex += maxResultsPerRequest;
          hasMore = startIndex < (40);
        } else {
          hasMore = false; // No more items
        }
      }
      return right(allBooks);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, BookModel>> fetchSpecificBook(String bookId) async {
    try {
      final data = await apiService.get(
        endPoint: 'volumes/$bookId',
      );
      final BookModel bookModel = BookModel.fromJson(data);
      return right(bookModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }

  }

}
