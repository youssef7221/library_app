import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  final String _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio = Dio(); // Create a single Dio instance

  // Private named constructor
  ApiService._internal();

  // Factory constructor returns the same instance
  factory ApiService() {
    return _instance;
  }

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    final response = await _dio.get('$_baseUrl$endPoint');
    return response.data;
  }
}
