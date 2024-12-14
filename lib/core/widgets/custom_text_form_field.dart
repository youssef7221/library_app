import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../password_cubit/password_cubit.dart';
import '../utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final FormFieldSetter<String>? onSaved;
  final Icon? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isConfirmPassword;
  const CustomTextField({
    super.key,
    this.isConfirmPassword = false,
    required this.hintText,
    required this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.controller,
    this.prefixIcon,
    this.suffixIcon ,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context){
    bool isObscure = context.watch<PasswordCubit>().isObscure;
    return TextFormField(
      controller: controller,
        validator: validator,
        focusNode: focusNode,
        keyboardType: keyboardType,
        obscureText: isConfirmPassword ? true : obscureText ? isObscure : false,
        cursorColor: AppColors.logoColor,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: AppColors.grey
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          hintText: hintText,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.grey,
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
