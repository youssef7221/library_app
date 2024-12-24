import 'package:hive_flutter/adapters.dart';

import '../../Features/home/manager/data/models/book_model/book_model.dart';
import '../../Features/home/manager/data/models/book_model/image_links.dart';
import '../../Features/home/manager/data/models/book_model/sale_info.dart';
import '../../Features/home/manager/data/models/book_model/volume_info.dart';

part 'MyBookModelHive.g.dart';
@HiveType(typeId: 0)
class MyBookModelHive extends HiveObject {
  @HiveField(0)
  final String id; // Book ID
  @HiveField(1)
  final String title; // Book title
  @HiveField(2)
  final String author; // Author name
  @HiveField(3)
  final String thumbnail; // Thumbnail URL
  @HiveField(4)
  final double price; // Book price
  @HiveField(5)
  final String description; // Book description

  MyBookModelHive({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnail,
    required this.price,
    required this.description,
  });

  /// Convert from `BookModel` to `MyBookModelHive`
  factory MyBookModelHive.fromBookModel(BookModel book) {
    return MyBookModelHive(
      id: book.id ?? '',
      title: book.volumeInfo.title ?? 'Unknown Title',
      author: book.volumeInfo.authors?.join(', ') ?? 'Unknown Author',
      thumbnail: book.volumeInfo.imageLinks?.thumbnail ?? '',
      price: book.saleInfo?.listPrice?.amount ?? 0.0,
      description: book.volumeInfo.description ?? '',
    );
  }
  BookModel toBookModel() {
    return BookModel(
      id: id,
      volumeInfo: VolumeInfo(
        title: title,
        authors: [author],
        description: description,
        imageLinks: ImageLinks(thumbnail: thumbnail, smallThumbnail: ''),
        // Add any default or placeholder values for other `VolumeInfo` fields.
      ),
      saleInfo: SaleInfo(
        listPrice: Price(amount: price == 0 ? 600 : price),
      ),
    );
  }
}
