import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Features/home/presentation/views/tabs/settings_screen/widgets/settings_row.dart';
import 'package:library_app/core/router/app_router.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/utils/app_fonts.dart';

import '../../../../../../core/service_locator/service_locator.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_cubit.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: AppColors.blackColor,
                      size: 24,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Settings",
                      style: AppFonts.boldFont.copyWith(fontSize: 26),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SettingsRow(label: "Account Settings"),
                SizedBox(
                  height: 20,
                ),
                SettingsRow(label: "Act As Seller"),
                SizedBox(
                  height: 20,
                ),
                SettingsRow(label: "Help & Support"),
                SizedBox(
                  height: 20,
                ),
                SettingsRow(label: "Theme mode"),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      context.read<UserCubit>().deleteUser();
                      GoRouter.of(context).pushReplacement(
                          AppRouter.kLoginView);
                    },
                    child: SettingsRow(label: "Log Out"))
              ],
            ),
          );
        },
      ),
    );
  }
}
