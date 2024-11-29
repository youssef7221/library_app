import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text,
  });
  final String text;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Container(
          height: 55,
          width: 190,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors:[
              AppColors.primaryColor,
              AppColors.primaryColor
            ]),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(child: Text(text,style: AppFonts.buttonFont,)),
        ),
      ),
    );
  }
}
