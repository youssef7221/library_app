import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key, required this.rating, required this.category,required this.pageCount});
  final num? rating;
  final String? category;
  final num? pageCount;
  @override
  Widget build(BuildContext context) {
    return                 Container(
      width: MediaQuery.of(context).size.width*.9,
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 30,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "${rating?? "4.5"}",
                style: AppFonts.smallFont
                    .copyWith(color: AppColors.blackColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            category ?? "Unknown",
            style: AppFonts.smallFont
                .copyWith(color: AppColors.blackColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "${pageCount ?? "4.5"} Pages",
            style: AppFonts.smallFont
                .copyWith(color: AppColors.blackColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}