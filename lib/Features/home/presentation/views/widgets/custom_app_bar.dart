import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Row(
        children: [
          Image.asset(
            AppImages.logo,
            height: 50,
          ),
          const Spacer(),
          IconButton(
              onPressed: () async{
                GoRouter.of(context).replace(AppRouter.kLoginView);
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                size: 22,
              ))
        ],
      ),
    );
  }
}
