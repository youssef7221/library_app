import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/Features/login/presentation/widgets/loginbuttons.dart';
import 'package:library_app/Features/login/presentation/widgets/signupline.dart';
import '../../../../core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/logo.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return  Form(
      key: cubit.formKey,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 50.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints:
                BoxConstraints(maxHeight: 180.h, maxWidth: 200.w),
                child: Logo(
                  logoHeight: 100.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 300.w,
                child: CustomTextField(
                  hintText: "Enter Your Email",
                  prefixIcon: const Icon(Icons.person),
                  controller: cubit
                      .emailTextEditingController,
                  validator: Validators.emailValidate,
                  focusNode: cubit.focusNode,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 300.w,
                child: CustomTextField(
                  hintText: "Enter Your Password",
                  validator: Validators.passwordValidate,
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  controller: cubit
                      .passwordTextEditingController, // Use the `controller` parameter
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              LoginButtons(),
              SizedBox(
                height: 40.h,
              ),
              SignUpLine()
            ],
          ),
        ),
      ),
    );
  }
}