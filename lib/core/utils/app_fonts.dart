import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
class AppFonts{
  static TextStyle semiBoldFont = GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w500
  );
  static  TextStyle bookFont = GoogleFonts.montserrat(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400
  );

  static  TextStyle smallFont = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static  TextStyle boldFont = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor
  );

  static  TextStyle buttonFont = GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white
  );
  static TextStyle sloganFont = GoogleFonts.indieFlower(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.blackColor
  );


  static TextStyle logoFont = GoogleFonts.sevillana(
      fontSize: 40,
      fontWeight: FontWeight.w800,
      color: AppColors.blackColor
  );
}