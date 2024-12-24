import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: AppColors.blackColor,
                      size: 24.r,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Settings",
                      style: AppFonts.boldFont.copyWith(fontSize: 26.sp),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () => GoRouter.of(context).push(AppRouter.kAccountView),
                    child: SettingsRow(label: "Account Settings")),
                SizedBox(
                  height: 15.h,
                ),
                SettingsRow(label: "Help & Support"),
                SizedBox(
                  height: 15.h,
                ),
                SettingsRow(label: "Theme mode"),
                SizedBox(
                  height: 15.h,
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
