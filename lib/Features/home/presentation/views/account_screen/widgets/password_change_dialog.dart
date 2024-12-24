import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/custom_change_pass_field.dart';
import 'package:library_app/core/shared_cubits/auth_cubit/auth_cubit.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/widgets/custom_button.dart';
import '../../../../../../core/shared_cubits/auth_cubit/auth_state.dart';
import '../../../../../../core/utils/validators.dart';

class PasswordChangeDialog extends StatefulWidget {
  const PasswordChangeDialog({super.key});

  @override
  State<PasswordChangeDialog> createState() => _SimplePasswordDialogState();
}

class _SimplePasswordDialogState extends State<PasswordChangeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose(){
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _handleSubmit(String currentPassword, String newPassword, BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      if (currentPassword != newPassword) {
        await context.read<AuthCubit>().handleChangePasword(
          currentPassword,
          newPassword,
          context,
        );
      }else
      {
        context.read<AuthCubit>().showErrorDialog(
          context,
          "The new password cannot be the same as the current password.",
        );
      }
    }
  }
  @override
  Widget build(BuildContext context){
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20.r),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Current Password
                    CustomChangePassField(
                      controller: _currentPasswordController,
                      labelText: "Current password",
                      validator: Validators.passwordValidate,
                    ),
                    SizedBox(height: 16.h),
                    // New Password
                    CustomChangePassField(
                      controller: _newPasswordController,
                      labelText: "New password",
                      validator: Validators.passwordValidate,
                    ),
                    const SizedBox(height: 16),
                    // Confirm Password
                    CustomChangePassField(
                      controller: _confirmPasswordController,
                      labelText: "Confirm password",
                      validator: (value) =>
                          Validators.confirmPasswordValidate(
                              value, _newPasswordController.text),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Password must be at least 6 characters',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        SizedBox(width: 16.w),
                        InkWell(
                          onTap: () =>
                              _handleSubmit(
                                  _currentPasswordController.text,
                                  _newPasswordController.text,
                                  context),
                          child: CustomButton(
                              text: "Change Password",
                              textColor: AppColors.blackColor,
                              buttonColor: AppColors.greyOpacity),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
