import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/app_color.dart';
import '../utils/app_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text,
    required this.textColor,
    required this.buttonColor,
     this.haveIcon = false
  });
  final String text;
  final Color buttonColor;
  final bool haveIcon;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Container(
          height: 40.h,
          width: 140.w,
          decoration: BoxDecoration(
            color: buttonColor,
              borderRadius: BorderRadius.circular(20.r)
          ),
          child: haveIcon ? Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Icon(FontAwesomeIcons.google,size: 30,color:AppColors.grey,),
              ),
              Center(child: Text(text,style: AppFonts.buttonFont.copyWith(
                color: textColor
              ),)),
            ],
          ) : Center(child: Text(text,style: AppFonts.buttonFont.copyWith(
              color: textColor
          ),)),
        ),
      ),
    );
  }
}
