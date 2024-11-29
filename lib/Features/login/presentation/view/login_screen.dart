import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/utils/app_router.dart';
import 'package:library_app/core/utils/firebase_service.dart';
import 'package:library_app/core/widgets/custom_button.dart';
import 'package:library_app/core/widgets/logo.dart';

import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/utils/validators.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 250,
                        maxWidth: 200
                      ),
                    child: Logo(
                        logoHeight: 150,
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
                        controller: emailTextEditingController,
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
                        controller: passwordTextEditingController, // Use the `controller` parameter
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: ()=> _handleLogin(AppRouter.kLoginView),
                          child:CustomButton(text: "Login")
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: ()=>_handleLogin(AppRouter.kSellerView),
                          child: CustomButton(text: "Login As Seller")
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.kRegisterView);
                          },
                          child:CustomButton(text: "Register")
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
  void _handleLogin(String route) {
    if (formKey.currentState!.validate()) {
      FirebaseService.loginUser(
        emailTextEditingController.text,
        passwordTextEditingController.text,
            () {
          GoRouter.of(context).replace(route); // Navigate to the specific route
        },
            (error) {
          _showErrorDialog(error.toString()); // Use the reusable error dialog
        },
      );
    }
  }
}
