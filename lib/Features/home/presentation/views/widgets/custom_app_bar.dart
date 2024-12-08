import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/utils/app_fonts.dart';
import 'package:library_app/core/widgets/search_widget.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flutterSecureStorage = getIt<FlutterSecureStorage>();
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      child: Row(
        children:[
          SearchWidget()
          // IconButton(
          //     onPressed: () async{
          //       GoRouter.of(context).replace(AppRouter.kLoginView);
          //       flutterSecureStorage.delete(key: 'user');
          //       await FirebaseAuth.instance.signOut();
          //     },
          //     icon: const Icon(
          //       Icons.logout,
          //       size: 22,
          //     ))
        ],
      ),
    );
  }
}
