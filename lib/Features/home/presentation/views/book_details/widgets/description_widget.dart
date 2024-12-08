import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.description});
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: AppFonts.boldFont,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                description??
                    "No description available.",
                style: AppFonts.smallFont.copyWith(
                    color: AppColors.blackColor),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    )
    ;
  }
}
