import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/app_color.dart';
import '../../../../../../../core/utils/app_fonts.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(5.r)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.w),
            child: Text(
              label,
              style: AppFonts.boldFont.copyWith(fontSize: 14.sp),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}
