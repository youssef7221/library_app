import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/widgets/custom_button.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        InkWell(
            onTap: () {
              context
                  .read<AuthCubit>()
                  .handleLogin(AppRouter.kHomeView, false, context);
            },
            child: CustomButton(
                text: AppString.login,
                buttonColor: AppColors.grey,
                textColor: AppColors.primaryColor)),
         SizedBox(
          width: 10.w,
        ),
        InkWell(
          onTap:state.isLoading
              ? null
              : () => context
                  .read<AuthCubit>()
                  .handleLogin(AppRouter.kHomeView, true, context),
          child: CustomButton(
            text: AppString.login,
            textColor: AppColors.grey,
            buttonColor: AppColors.primaryColor,
            haveIcon: true,
          ),
        ),
      ],
    );
  }
}
