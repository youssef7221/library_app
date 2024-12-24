import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import '../../auth_firebase/auth_firebase.dart';
import '../../firebase_service/firebase_service.dart';
import '../../flutter_secure/flutter_secure.dart';
import '../../router/app_router.dart';
import '../../utils/app_color.dart';
import '../../utils/app_fonts.dart';
import '../../utils/model/userdm.dart';
import '../user_cubit/user_cubit.dart';
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

  void showSuccessDialog({
    required BuildContext context,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 48.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    GoRouter.of(context).replace(AppRouter.kLoginView);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 45.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    buttonText ?? 'OK',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
          clearTextController();
          await storage.saveData("user", userModel!);
          context.read<UserCubit>().updateUser(userModel);
          // Save token and user info
          GoRouter.of(context).replace(route); // Navigate to the route
        },
        (error) => showErrorDialog(context, error.toString()),
      );
    }
  }

  Future<void> handleChangePasword(
      String currentPassword, String newPassword, BuildContext context) async {
    try {
      startLoading(); // Show loading indicator
      await authService.changePassword(
        currentPassword,
        newPassword,
        // On error
        (error) {
          stopLoading();
          showErrorDialog(context, error.toString());
        },
        // On success
        () async {
          stopLoading();
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
          showSuccessDialog(
              context: context,
              message:
                  "Password changed successfully. User signed out for security"); // Navigate to the route
        },
      );
    } catch (e) {
      stopLoading();
      showErrorDialog(context, "Unexpected error occurred: ${e.toString()}");
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
