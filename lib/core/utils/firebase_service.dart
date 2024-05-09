import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_app/core/utils/model/sellerdm.dart';
import 'model/userdm.dart';

class FirebaseService{
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(fromFirestore: (snapshot, _) {
      return UserModel.fromjson(snapshot.data()!);
    }, toFirestore: (value, _) {
      return value.tojson();
    });
  }

  static Future<void> addUserCollection(UserModel user) {
    var collections = getUsersCollection();
    var Doc = collections.doc(user.id);
    return Doc.set(user);
  }

  static Future<void> createUser(String name, int age, String email,
      String password, Function onSuccess, Function onError) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:email,
        password: password,
      );
      UserModel userModel = UserModel(
          name: name, email: email, age: age, id: credential.user!.uid);
      FirebaseService.addUserCollection(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }


  static CollectionReference<SellerModel> getSellerCollection() {
    return FirebaseFirestore.instance
        .collection("Seller")
        .withConverter<SellerModel>(fromFirestore: (snapshot, _) {
      return SellerModel.fromjson(snapshot.data()!);
    }, toFirestore: (value, _) {
      return value.tojson();
    });
  }

  static Future<void> addSellerCollection(SellerModel seller) {
    var collections = getSellerCollection();
    var Doc = collections.doc(seller.id);
    return Doc.set(seller);
  }

  static Future<void> createSeller(String name, int age, String email,
      String password, Function onSuccess, Function onError) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:email,
        password: password,
      );
      SellerModel sellerModel = SellerModel(
          name: name, email: email, age: age, id: credential.user!.uid);
      FirebaseService.addSellerCollection(sellerModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static void loginUser(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if(e.message == 'The supplied auth credential is incorrect, malformed or has expired.')
        onError("Invalid Email or Password");
    }
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userDoc =
    await getUsersCollection().doc(id).get();
    return userDoc.data();
  }
}