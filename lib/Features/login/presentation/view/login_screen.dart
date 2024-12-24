import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/login/presentation/widgets/loginform.dart';
import '../../../../core/loading_overlay/loadingoverlay.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/shared_cubits/auth_cubit/auth_state.dart';
import '../../../../core/shared_cubits/password_cubit/password_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.error != null) {
            context.read<AuthCubit>().showErrorDialog(context, state.error!);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: LoginForm()
              ),
              if (state.isLoading)
                LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}
