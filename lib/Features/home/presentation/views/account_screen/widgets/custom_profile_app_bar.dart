import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';

class CustomProfileAppBar extends StatelessWidget {
  const CustomProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0.h,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.whiteColor,
      flexibleSpace: FlexibleSpaceBar(
        title:  Text(
          'Profile',
          style: AppFonts.boldFont,
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primaryColor, AppColors.whiteColor],
            ),
          ),
        ),
      ),
    );
  }
}
