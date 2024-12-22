import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_string.dart';

class SignUpLine extends StatelessWidget {
  const SignUpLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppString.dontHaveAcc,
          style: AppFonts.smallFont
              .copyWith(color: AppColors.primaryColor),
        ),
         SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () => GoRouter.of(context)
              .push(AppRouter.kRegisterView),
          child: Text(
            AppString.signUp,
            style: AppFonts.smallFont
                .copyWith(color: AppColors.logoColor),
          ),
        )
      ],
    )
    ;
  }
}
