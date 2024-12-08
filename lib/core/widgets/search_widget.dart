import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/router/app_router.dart';

import '../utils/app_color.dart';
import '../utils/app_fonts.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoRouter.of(context).push(AppRouter.kSearchView),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            border: Border.all(color: AppColors.textField,width: 0.45),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(Icons.search,color: AppColors.whiteColor,size: 24,),
              SizedBox(width: 10,),
              Text("What do you want to read ?",style: AppFonts.smallFont,)
            ],
          ),
        ),
      ),
    )
    ;
  }
}
