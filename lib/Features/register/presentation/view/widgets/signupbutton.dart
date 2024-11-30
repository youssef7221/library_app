import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/utils/auth_cubit/auth_cubit.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_string.dart';
import '../../../../../core/widgets/custom_button.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    return Center(
      child: InkWell(
        onTap: state.isLoading
            ? null
            : () => context
            .read<AuthCubit>()
            .handleSignUp(context),
        child: CustomButton(
          text: AppString.signUp,
          textColor: AppColors.baseShimmer,
          buttonColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
