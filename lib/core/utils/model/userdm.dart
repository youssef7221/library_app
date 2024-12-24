import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? name;
  String? email;
  int? age;
  String? id;
  List? books;
  UserModel(
      {required this.name,
        required this.email,
        required this.age,
        required this.id,
       required this.books});

  UserModel.fromjson (Map <String , dynamic > json) : this (
    name : json['name'],
    age : json['age'],
    email : json['email'],
    id : json['id'],
    books:json['books']
  );

  Map<String , dynamic>tojson(){
    return {'name' : name,
      'age' : age,
      'email' : email,
      'id' : id,
      'books':books
    };
  }
}