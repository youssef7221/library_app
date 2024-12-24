import 'package:flutter/material.dart';
import 'package:library_app/core/utils/app_fonts.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(child: Text("Something Went Wrong",style: AppFonts.boldFont,)),
    );
  }
}
