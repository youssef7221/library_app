import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/register/presentation/view/widgets/signupbutton.dart';
import '../../../../../core/utils/auth_cubit/auth_cubit.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/logo.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthCubit>().formKey,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                    maxHeight: 180, maxWidth: 200),
                child: const Logo(logoHeight: 100),
              ),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: "Enter your name",
                  prefixIcon: const Icon(Icons.person),
                  controller: context
                      .read<AuthCubit>()
                      .nameTextEditingController,
                  validator: Validators.nameValidate,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: "Enter Your Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  controller: context
                      .read<AuthCubit>()
                      .emailTextEditingController,
                  validator: Validators.emailValidate,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: "Enter Your password",
                  prefixIcon: const Icon(Icons.lock),
                  controller: context
                      .read<AuthCubit>()
                      .passwordTextEditingController,
                  validator: Validators.passwordValidate,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: "Confirm password",
                  prefixIcon: const Icon(Icons.lock_open),
                  isConfirmPassword: true,
                  controller: context
                      .read<AuthCubit>()
                      .confirmPasswordTextEditingController,
                  validator: (value) =>
                      Validators.confirmPasswordValidate(
                          value,
                          context
                              .read<AuthCubit>()
                              .passwordTextEditingController
                              .text),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 30),
              SignUpButton()
            ],
          ),
        ),
      ),
    );
  }
}
