import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/model/userdm.dart';

class FirebaseService {
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
    var doc = collections.doc(user.id);
    return doc.set(user);
  }

  Future<void> addBookToUser(
      String? userId, String? bookId, Function onError) async {
    try {
      var userDoc = getUsersCollection().doc(userId);
      await userDoc.update({
        'books': FieldValue.arrayUnion([bookId])
      });
    } catch (e) {
      onError(e.toString());
    }
  }

// Helper function to derive name from email
  static String deriveNameFromEmail(String? email) {
    if (email == null || email.isEmpty) return "Anonymous";
    // Extract the part before the "@" and replace numbers with spaces
    String rawName = email.split('@').first.replaceAll(RegExp(r'\d'), ' ');
    // Capitalize each part of the name
    List<String> nameParts =
        rawName.split(' ').where((part) => part.isNotEmpty).toList();
    return nameParts
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');
  }

  Future<UserModel?> readUser(String? id) async {
    try {
      DocumentSnapshot<UserModel> userDoc = await getUsersCollection()
          .doc(id)
          .get(const GetOptions(source: Source.server)); // Force server fetch
      return userDoc.data();
    } catch (e) {
      print("Error fetching user: $e");
      return null; // Handle the error appropriately in your app
    }
  }

// static CollectionReference<SellerModel> getSellerCollection() {
//   return FirebaseFirestore.instance
//       .collection("Seller")
//       .withConverter<SellerModel>(fromFirestore: (snapshot, _) {
//     return SellerModel.fromjson(snapshot.data()!);
//   }, toFirestore: (value, _) {
//     return value.tojson();
//   });
// }
//
// static Future<void> addSellerCollection(SellerModel seller) {
//   var collections = getSellerCollection();
//   var doc = collections.doc(seller.id);
//   return doc.set(seller);
// }
//
// static Future<void> createSeller(String name, int age, String email,
//     String password, Function onSuccess, Function onError) async {
//   try {
//     final credential =
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email:email,
//       password: password,
//     );
//     SellerModel sellerModel = SellerModel(
//         name: name, email: email, age: age, id: credential.user!.uid);
//     FirebaseService.addSellerCollection(sellerModel);
//     onSuccess();
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       onError(e.message);
//     } else if (e.code == 'email-already-in-use') {
//       onError(e.message);
//     }
//   } catch (e) {
//     print(e);
//   }
// }
}
