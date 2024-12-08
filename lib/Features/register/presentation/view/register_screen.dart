import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/register/presentation/view/widgets/registerform.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import '../../../../core/auth_cubit/auth_cubit.dart';
import '../../../../core/auth_cubit/auth_state.dart';
import '../../../../core/password_cubit/password_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<AuthCubit>()),
          BlocProvider(
            create: (context) => getIt<PasswordCubit>(),
          ),
        ],
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.error != null) {
              context.read<AuthCubit>().showErrorDialog(context, state.error!);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    child: RegisterForm()
                  ),
                ),
                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.grey,
                        size: 40,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
