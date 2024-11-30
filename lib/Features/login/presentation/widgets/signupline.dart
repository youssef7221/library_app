import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/router/app_router.dart';

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
        const SizedBox(
          width: 10,
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
