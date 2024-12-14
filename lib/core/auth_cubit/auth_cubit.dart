import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/user_cubit/user_cubit.dart';

import '../auth_firebase/auth_firebase.dart';
import '../firebase_service/firebase_service.dart';
import '../flutter_secure/flutter_secure.dart';
import '../router/app_router.dart';
import '../utils/app_color.dart';
import '../utils/app_fonts.dart';
import '../utils/model/userdm.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final storage = getIt<SecureStorageManager>();
  final authService = getIt<AuthFirebase>();
  final FocusNode focusNode = FocusNode();
  final fireBaseService = getIt<FirebaseService>();

  void startLoading() => emit(state.copyWith(isLoading: true));

  void stopLoading() => emit(state.copyWith(isLoading: false));

  void setError(String error) =>
      emit(state.copyWith(isLoading: false, error: error));

  void showErrorDialog(BuildContext context, String errorMessage) {
    bool isDialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Error",
            style: AppFonts.boldFont,
          ),
          content: Text(
            errorMessage,
            style: AppFonts.smallFont,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                stopLoading();
                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.redColor),
              child: Text(
                "Ok",
                style: AppFonts.boldFont.copyWith(color: Colors.white),
              ),
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

  void clearTextController() {
    nameTextEditingController.clear();
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    confirmPasswordTextEditingController.clear();
  }

  void handleSignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      startLoading();
      await authService.createUser(
        nameTextEditingController.text,
        0,
        emailTextEditingController.text,
        passwordTextEditingController.text,
        () {
          stopLoading();
          focusNode.unfocus();
          GoRouter.of(context).replace(AppRouter.kLoginView);
        },
        (error) {
          setError(error.toString());
        },
      );
      clearTextController();
    }
  }

  Future<void> handleLogin(
      String route, bool isGmail, BuildContext context) async {
    if (isGmail) {
      await authService.signInWithGoogle(() async {
        stopLoading();
        final user = FirebaseAuth.instance.currentUser;
        UserModel? userModel = await fireBaseService.readUser(user!.uid);
        await storage.saveData("user", userModel!);
        context.read<UserCubit>().updateUser(userModel);
        GoRouter.of(context).replace(route); // Navigate to the specific route
      }, (error) => showErrorDialog(context, error.toString()));
    } else {
      if (!formKey.currentState!.validate()) {
        stopLoading(); // Stop loading if validation fails
        return;
      }
      startLoading();
      await authService.loginUser(
        emailTextEditingController.text,
        passwordTextEditingController.text,
        () async {
          focusNode.unfocus();
          stopLoading();
          final user = FirebaseAuth.instance.currentUser;
          UserModel? userModel = await fireBaseService.readUser(user!.uid);
          await storage.saveData("user", userModel!);
          context.read<UserCubit>().updateUser(userModel);
          // Save token and user info
          GoRouter.of(context).replace(route); // Navigate to the route
        },
        (error) => showErrorDialog(context, error.toString()),
      );
    }
  }

  Future<void> handleSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // Clear user in UserCubit
    context.read<UserCubit>().deleteUser();

    // Navigate to login screen
    GoRouter.of(context).replace(AppRouter.kLoginView);
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
