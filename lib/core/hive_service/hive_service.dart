import 'package:hive_flutter/hive_flutter.dart';
import '../../Features/home/manager/data/models/book_model/book_model.dart';
import '../book_model/MyBookModelHive.dart';

class HiveService {
  static const String boxName = 'favoriteBooks';

  Future<void> initHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(MyBookModelHiveAdapter().typeId)) {
      Hive.registerAdapter(MyBookModelHiveAdapter());
    }
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<MyBookModelHive>(boxName);
    }
  }

  /// Save a book for a specific user
  Future<void> saveBook(String? userId, BookModel book) async {
    final box = Hive.box<MyBookModelHive>(boxName);
    String key = '$userId-${book.id}';
    // Convert BookModel to MyBookModelHive before saving
    final hiveBook = MyBookModelHive.fromBookModel(book);
    await box.put(key, hiveBook);
  }

  /// Get all books for a specific user
  List<MyBookModelHive> getBooks(String? userId) {
    final box = Hive.box<MyBookModelHive>(boxName);
    return box.keys
        .where((key) => key.toString().startsWith('$userId-'))
        .map((key) => box.get(key)!)
        .toList();
  }

  /// Delete a specific book for a user
  Future<void> deleteBook(String? userId, String? bookId) async {
    final box = Hive.box<MyBookModelHive>(boxName);
    String key = '$userId-$bookId';
    await box.delete(key);
  }

  /// Clear all books for a specific user
  Future<void> clearUserBooks(String userId) async {
    final box = Hive.box<MyBookModelHive>(boxName);
    final keysToRemove = box.keys
        .where((key) => key.toString().startsWith('$userId-'))
        .toList();
    await box.deleteAll(keysToRemove);
  }

  /// Check if a book exists for a user
  bool isBookSaved(String? userId, String? bookId) {
    final box = Hive.box<MyBookModelHive>(boxName);
    String key = '$userId-$bookId';
    return box.containsKey(key);
  }
}