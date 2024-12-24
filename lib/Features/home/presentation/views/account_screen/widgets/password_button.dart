import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/password_change_dialog.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/shared_cubits/auth_cubit/auth_cubit.dart';

import '../../../../../../core/utils/app_color.dart';

class PasswordButton extends StatelessWidget {
  const PasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    void handleChangePassword() {
      print('Password button tapped!');
      showDialog(
        context: context,
        builder: (context) {
          print('Dialog opened');
          return BlocProvider.value(
            value: getIt<AuthCubit>(),
            child: PasswordChangeDialog(),
          );
        },
      );
    }
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1200),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: handleChangePassword,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.whiteColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            'Change Password',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor
            ),
          ),
        ),
      ),
    );
  }
}
