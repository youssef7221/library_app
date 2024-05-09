import 'package:firebase_auth/firebase_auth.dart';

class SellerModel {
  String? name;
  String? email;
  int? age;
  List<String>? books;
  String? id;

  SellerModel({
    required this.name,
    required this.email,
    required this.age,
    required this.id,
    this.books
  });

  SellerModel.fromjson(Map<String, dynamic> json)
      : this(
    name: json['name'] , // Assert it's a String
    email: json['email'] as String,
    age: json['age'] as int,
    id: json['id'] as String,
    books: json['books']?.cast<String>(), // Handle null or cast to List<String>
  );

  Map<String , dynamic>tojson(){
    return {'name' : name,
      'age' : age,
      'email' : email,
      'id' : id,
    };
  }
}