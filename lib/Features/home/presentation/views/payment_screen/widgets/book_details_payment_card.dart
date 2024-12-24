import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/widgets/custom_book_item.dart';
import '../../../../manager/data/models/book_model/book_model.dart';

class BookDetailsPaymentCard extends StatelessWidget {
  const BookDetailsPaymentCard({super.key, required this.selectedBook});
  final BookModel selectedBook;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book Thumbnail
          Container(
            width: 80.w,
            height: 110.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: CustomBookImage(imageUrl: selectedBook.volumeInfo.imageLinks!.thumbnail),
          ),
          SizedBox(width: 15.w),
          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedBook.volumeInfo.title ?? 'Unknown Book',
                  style: AppFonts.boldFont.copyWith(fontSize: 16.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                 selectedBook.volumeInfo.authors?.first ?? 'Unknown Author',
                  style: AppFonts.smallFont.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 10.h),
                Text(
                  '${selectedBook.saleInfo?.listPrice?.amount?.truncate() ?? 600} EGP',
                  style: AppFonts.boldFont.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );  }
}
