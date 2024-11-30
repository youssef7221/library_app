import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/utils/auth_firebase/auth_firebase.dart';
import 'package:library_app/core/utils/flutter_secure/flutter_secure.dart';

import '../firebase_service/firebase_service.dart';
import '../model/userdm.dart';
import '../router/app_router.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final storage = const FlutterSecureStorage();

  void startLoading() => emit(state.copyWith(isLoading: true));

  void stopLoading() => emit(state.copyWith(isLoading: false));

  void setError(String error) =>
      emit(state.copyWith(isLoading: false, error: error));

  void showErrorDialog(BuildContext context, String errorMessage) {
    bool isDialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                stopLoading();
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    ).then((_) {
      if (isDialogOpen) {
        stopLoading();
      }
    });
  }

  void handleSignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      startLoading();
      await AuthFirebase.createUser(
        nameTextEditingController.text,
        0,
        emailTextEditingController.text,
        passwordTextEditingController.text,
        () {
          stopLoading();
          GoRouter.of(context).replace(AppRouter.kLoginView);
        },
        (error) {
          setError(error.toString());
        },
      );
      nameTextEditingController.clear();
      emailTextEditingController.clear();
      passwordTextEditingController.clear();
      confirmPasswordTextEditingController.clear();
    }
  }

  void handleLogin(String route, bool isGmail, BuildContext context) async {
    if (isGmail) {
      await AuthFirebase.signInWithGoogle(() async {
        stopLoading();
        final user = FirebaseAuth.instance.currentUser;
        UserModel? userModel = await FirebaseService.readUser(user!.uid);
        await SecureStorageManager().saveData("user", userModel!);
        GoRouter.of(context).replace(route); // Navigate to the specific route
      }, (error) => showErrorDialog(context, error.toString()));
    } else {
      if (!formKey.currentState!.validate()) {
        stopLoading(); // Stop loading if validation fails
        return;
      }
      startLoading();
      await AuthFirebase.loginUser(
        emailTextEditingController.text,
        passwordTextEditingController.text,
        () async {
          stopLoading();
          final user = FirebaseAuth.instance.currentUser;
          UserModel? userModel = await FirebaseService.readUser(user!.uid);
          await SecureStorageManager().saveData("user", userModel!);
          // Save token and user info
          GoRouter.of(context).replace(route); // Navigate to the route
        },
        (error) => showErrorDialog(context, error.toString()),
      );
    }
  }

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  final TextEditingController nameTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
