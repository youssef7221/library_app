import 'package:flutter/material.dart';
import 'package:library_app/core/widgets/search_widget.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
