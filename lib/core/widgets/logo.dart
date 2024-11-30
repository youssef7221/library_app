
import 'package:flutter/material.dart';
import 'package:library_app/core/utils/app_images.dart';
import 'package:library_app/core/utils/app_string.dart';

import '../utils/app_fonts.dart';

class Logo extends StatelessWidget {
  const Logo(
      {super.key,
      required this.logoHeight});
   final double? logoHeight;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(AppImages.logo,
          height: logoHeight,),
        ),
        Center(child: Text(AppString.logoName,style:AppFonts.logoFont),)
      ],
    );
  }
}
