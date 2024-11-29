import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_color.dart';
import '../utils/password_cubit/password_cubit.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final FormFieldSetter<String>? onSaved;
  final Icon? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    bool isObscure = context.watch<PasswordCubit>().isObscure;
    return TextFormField(
      controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText ? isObscure : false,
        cursorColor: AppColors.logoColor,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: obscureText
              ? IconButton(
            icon: Icon(
              isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              context.read<PasswordCubit>().changePassVis();
            },
          )
              : null,
          filled: true,
          fillColor: AppColors.primaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
    );
  }
}
