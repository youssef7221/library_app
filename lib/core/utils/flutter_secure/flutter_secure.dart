import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/userdm.dart';

class SecureStorageManager {
  // Create a singleton instance
  static final SecureStorageManager _instance = SecureStorageManager._internal();

  // FlutterSecureStorage instance
  static final _storage = FlutterSecureStorage();

  // Private constructor for singleton
  SecureStorageManager._internal();

  // Factory constructor to return the singleton instance
  factory SecureStorageManager() => _instance;

  // Save a value by key
   Future<void> saveData(key , UserModel user) async {
    String userJson = jsonEncode(user.tojson());
    await _storage.write(key: key , value: userJson);
  }

  // Retrieve a value by key
  Future<UserModel?> readData(String key) async {
    String? userJson = await _storage.read(key: key);
    if (userJson == null) return null;
    return UserModel.fromjson(jsonDecode(userJson));  }

  // Delete a value by key
  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }

  // Check if a key exists
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  // Clear all stored data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
