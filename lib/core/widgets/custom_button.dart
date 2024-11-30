import 'package:flutter/material.dart';
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
          height: 50,
          width: 140,
          decoration: BoxDecoration(
            color: buttonColor,
              borderRadius: BorderRadius.circular(20)
          ),
          child: haveIcon ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(FontAwesomeIcons.google,size: 30,),
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
