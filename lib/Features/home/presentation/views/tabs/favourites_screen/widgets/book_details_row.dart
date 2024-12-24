import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Features/home/presentation/views/tabs/favourites_screen/widgets/remove_dialog.dart';
import 'package:library_app/core/book_model/MyBookModelHive.dart';
import 'package:library_app/core/router/app_router.dart';

import '../../../../../../../core/utils/app_color.dart';
import '../../../../../../../core/utils/app_fonts.dart';
import '../../../../../../../core/widgets/custom_book_item.dart';

class BookDetailsRow extends StatelessWidget {
  const BookDetailsRow({super.key, required this.selectedBook});

  final MyBookModelHive selectedBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book Thumbnail
          Container(
            width: 100.w,
            height: 125.h,
            margin: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: InkWell(
              onTap: () {
                final bookModel = selectedBook.toBookModel();
                GoRouter.of(context).push(AppRouter.kHomeDetailsView,extra: bookModel);
              },
                child: CustomBookImage(imageUrl: selectedBook.thumbnail)),
          ),
          // Book Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedBook.title,
                    style: AppFonts.boldFont.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.blackColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    selectedBook.author ?? 'Unknown Author',
                    style: AppFonts.smallFont.copyWith(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                   SizedBox(height: 10.h),
                  // Optional: Add more details or actions
                  Row(
                    children: [
                      IconButton(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          RemoveDialog.showRemoveBookDialog(
                              context, selectedBook.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
