import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';

class BooksAppBar extends StatelessWidget {
  const BooksAppBar(
      {super.key, required this.bookName, required this.bookAuthor});

  final String? bookName;
  final String? bookAuthor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(60.r),
          ),
          child: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: Icon(
              Icons.arrow_back,
              size: 24.r,
              color: AppColors.blackColor,
            ),
          ),
        ),
        SizedBox(width: 40.w),
        SizedBox(
          width: 200.w,
          child: Column(
            children: [
              Center(
                child: Text(
                  bookName ?? "Unknown",
                  style: AppFonts.bookFont.copyWith(
                      color: AppColors.blackColor, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Text(
                  bookAuthor ?? "Unknown",
                  style: AppFonts.smallFont,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
