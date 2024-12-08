import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/login/presentation/widgets/loginbuttons.dart';
import 'package:library_app/Features/login/presentation/widgets/signupline.dart';
import '../../../../core/auth_cubit/auth_cubit.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/logo.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: context.read<AuthCubit>().formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints:
                BoxConstraints(maxHeight: 180, maxWidth: 200),
                child: Logo(
                  logoHeight: 100,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: "Enter Your Email",
                  prefixIcon: const Icon(Icons.person),
                  controller: context
                      .read<AuthCubit>()
                      .emailTextEditingController,
                  validator: Validators.emailValidate,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: CustomTextField(
                  hintText: "Enter Your Password",
                  validator: Validators.passwordValidate,
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  controller: context
                      .read<AuthCubit>()
                      .passwordTextEditingController, // Use the `controller` parameter
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              LoginButtons(),
              const SizedBox(
                height: 40,
              ),
              SignUpLine()
            ],
          ),
        ),
      ),
    );
  }
}
