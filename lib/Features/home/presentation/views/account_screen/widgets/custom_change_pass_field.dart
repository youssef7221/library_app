import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/utils/app_fonts.dart';

class CustomChangePassField extends StatefulWidget {
  const CustomChangePassField({
    super.key,
    required this.controller,
    required this.labelText, this.validator,
  });
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String labelText;

  @override
  State<CustomChangePassField> createState() => _CustomChangePassFieldState();
}

class _CustomChangePassFieldState extends State<CustomChangePassField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      style: AppFonts.smallFont.copyWith(color: AppColors.blackColor,fontSize: 16.sp),
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}
