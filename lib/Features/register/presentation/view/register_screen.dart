import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Features/register/presentation/view/widgets/my_text_field.dart';
import 'package:library_app/constants.dart';
import 'package:library_app/core/utils/firebase_service.dart';

import '../../../../core/utils/assets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailTextEditingController = TextEditingController();
    TextEditingController passwordTextEditingController =
        TextEditingController();
    TextEditingController nameTextEditingController = TextEditingController();
    TextEditingController ageTextEditingController = TextEditingController();
    bool obscuredText = true;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? error;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AssetsData.logo,
                    height: 150,
                  ),
                  TextFormField(
                      controller: nameTextEditingController,
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          label: const Text("name")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please Enter Your Name";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: emailTextEditingController,
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          label: Text("Email")),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*"
                                    r"+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return "please Enter Your Email";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: obscuredText,
                    controller: passwordTextEditingController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "please Enter At least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: ageTextEditingController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          label: Text("Age")),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please Enter Your Age";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseService.createUser(
                                nameTextEditingController.text,
                                int.parse(ageTextEditingController.text),
                                emailTextEditingController.text,
                                passwordTextEditingController.text,
                                () => GoRouter.of(context).pop(), () {
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
                          width: 140,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                              child: Text(
                            "Sign Up as User",
                            style: TextStyle(color: kPrimaryColor),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseService.createSeller(
                                nameTextEditingController.text,
                                int.parse(ageTextEditingController.text),
                                emailTextEditingController.text,
                                passwordTextEditingController.text,
                                () => GoRouter.of(context).pop(), () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context){
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
                          width: 150,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(
                              child: Text(
                            "Sign Up as Seller or Renter",
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
    ));
  }
}
