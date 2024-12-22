import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/utils/app_fonts.dart';
import 'package:library_app/core/widgets/custom_book_item.dart';

import '../../../../../manager/data/models/book_model/book_model.dart';

class CustomMyBookView extends StatelessWidget {
  const CustomMyBookView({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.whiteColor,
      child: Container(
          width: 120.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              CustomBookImage(imageUrl: book.volumeInfo.imageLinks!.thumbnail),
              SizedBox(
                height: 10.h,
              ),
              Text(
                book.volumeInfo.title ?? "Unknown",
                style: AppFonts.bookFont,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
    );
  }
}
