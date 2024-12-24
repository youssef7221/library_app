import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/account_details_card.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/animated_card.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/custom_profile_app_bar.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/password_button.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/password_change_dialog.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/personal_information.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/widgets/profile_header.dart';
import 'package:library_app/core/shared_cubits/auth_cubit/auth_cubit.dart';

import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/shared_cubits/auth_cubit/auth_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          CustomProfileAppBar(),
          // Profile Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      ProfileHeader(),
                      SizedBox(height: 24.h),
                      AnimatedCard(
                        title: 'Personal Information',
                        delay: 0.2,
                        child: PersonalInformation(),
                      ),
                      SizedBox(height: 24.h),
                      AnimatedCard(
                        title: 'Account Details',
                        delay: 0.4,
                        child: AccountDetailsCard(),
                      ),
                      SizedBox(height: 24.h),
                      // Password Button
                      PasswordButton(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

