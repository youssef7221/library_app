import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/utils/app_string.dart';
import 'package:library_app/core/utils/auth_cubit/auth_cubit.dart';
import 'package:library_app/core/utils/auth_cubit/auth_state.dart';
import 'package:library_app/core/widgets/custom_button.dart';
import 'package:library_app/core/widgets/logo.dart';
import '../../../../core/utils/password_cubit/password_cubit.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(
            create: (context) => PasswordCubit(),
          ),
        ],
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.error != null) {
              context.read<AuthCubit>().showErrorDialog(context, state.error!);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    child: Form(
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
                              Center(
                                child: InkWell(
                                  onTap: state.isLoading
                                      ? null
                                      : () => context
                                          .read<AuthCubit>()
                                          .handleSignUp(context),
                                  child: CustomButton(
                                    text: AppString.signUp,
                                    textColor: AppColors.baseShimmer,
                                    buttonColor: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.baseShimmer,
                        size: 40,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
