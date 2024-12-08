import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';

class BooksAppBar extends StatelessWidget {
  const BooksAppBar({super.key,required this.bookName, required this.bookAuthor});
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
            borderRadius: BorderRadius.circular(60),
          ),
          child: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: Icon(
              Icons.arrow_back,
              size: 24,
              color: AppColors.blackColor,
            ),
          ),
        ),
        const SizedBox(width: 40),
        SizedBox(
          width: 200,
          child: Column(
            children: [
              Center(
                child:Text(
                  bookName?? "Unknown",
                  style: AppFonts.bookFont.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  bookAuthor ??
                      "Unknown",
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
