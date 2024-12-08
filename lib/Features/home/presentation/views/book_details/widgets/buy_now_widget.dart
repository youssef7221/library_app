import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';

class BuyNowWidget extends StatelessWidget {
  const BuyNowWidget({
    required this.price,
    super.key});
  final int? price ;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width*.9,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.bookmark,
              color: AppColors.blackColor,
              size: 30,
            ),
            Container
              (
              decoration: BoxDecoration(
                  color: AppColors.blackColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              width: MediaQuery.of(context).size.width*.6,
              child: Center(
                child: Text(
                  "Buy Now for ${price??600} EGP",
                  style: AppFonts.smallFont
                      .copyWith(color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
