import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_service/firebase_service.dart';
import '../utils/model/userdm.dart';

class AuthFirebase {
  Future<void> createUser(String name, int age, String email, String password,
      Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          name: name,
          email: email,
          age: age,
          id: credential.user!.uid,
          books: []);
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

  Future<void> changePassword(String currentPassword, String newPassword,
      Function onError, Function onSuccess) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user is currently signed in.',
        );
      }
      // Re-authenticate the user
      String email = user.email ?? '';
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update the password
      await user.updatePassword(newPassword);
      print('Password changed successfully. User signed out for security.');
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        onError(e.message);
        print('The current password is incorrect.');
      } else if (e.code == 'weak-password') {
        onError(e.message);
        print('The new password is too weak.');
      } else if (e.message ==
          'The supplied auth credential is incorrect, malformed or has expired.') {
        onError("The current password is incorrect.");
      } else {
        onError("Error Changing : ${e.message}");
        print('Error changing password: ${e.message}');
      }
    } catch (e) {
      onError(e.toString());
      print('Error: $e');
    }
  }

  Future<void> signInWithGoogle(Function onSuccess, Function onError) async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        onError("Google sign-in aborted.");
        return;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in with Firebase
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        // Extract or derive name
        String name =
            user.displayName ?? FirebaseService.deriveNameFromEmail(user.email);
        // Check if the user exists in Firestore
        final docSnapshot =
            await FirebaseService.getUsersCollection().doc(user.uid).get();
        if (!docSnapshot.exists) {
          // Add new user to Firestore
          UserModel userModel = UserModel(
              name: name,
              email: user.email ?? "",
              age: 0,
              id: user.uid,
              books: []);
          await FirebaseService.addUserCollection(userModel);
        }
        onSuccess();
      }
    } catch (e) {
      print(e);
      onError(e.toString());
    }
  }

  Future<void> loginUser(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.message ==
          'The supplied auth credential is incorrect, malformed or has expired.') {
        onError("Invalid Email or Password");
      } else if (e.message == "The email address is badly formatted.") {
        onError("The email address is badly formatted");
      } else {
        onError("Someting went wrong");
      }
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User signed out successfully.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
