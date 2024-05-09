import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/utils/app_router.dart';
import 'package:library_app/core/utils/assets.dart';
import 'package:library_app/core/utils/firebase_service.dart';

import '../../../../constants.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool obscuredText = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 51),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Image.asset(
                    AssetsData.logo,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailTextEditingController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*"
                                    r"+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return "please Enter Your Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("Enter Your Email"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return "please Enter Your Password";
                        }
                        return null;
                      },
                      obscureText: obscuredText,
                      controller: passwordTextEditingController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                obscuredText = !obscuredText;
                                setState(() {});
                              },
                              icon: obscuredText
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                          label:const Text("Enter Your Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                 const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseService.loginUser(
                                emailTextEditingController.text,
                                passwordTextEditingController.text, () {
                              GoRouter.of(context).replace(AppRouter.kHomeView);
                            }, (error) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(error.toString()),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"))
                                    ],
                                  );
                                },
                              );
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 120,
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Login",
                            style: TextStyle(color: kPrimaryColor),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseService.loginUser(
                                emailTextEditingController.text,
                                passwordTextEditingController.text, () {
                              GoRouter.of(context).replace(AppRouter.kSellerView);
                            }, (error) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(error.toString()),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"))
                                    ],
                                  );
                                },
                              );
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 120,
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Login as Seller",
                            style: TextStyle(color: kPrimaryColor),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.kRegisterView);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 120,
                          height: 50,
                          child: Center(
                              child: Text(
                            "Register",
                            style: TextStyle(color: kPrimaryColor),
                          )),
                        ),
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
}
