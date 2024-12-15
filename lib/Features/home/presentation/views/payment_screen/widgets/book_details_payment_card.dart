import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomBookImage(imageUrl: selectedBook.volumeInfo.imageLinks!.thumbnail),
          ),
          const SizedBox(width: 15),
          // Book Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedBook.volumeInfo.title ?? 'Unknown Book',
                  style: AppFonts.boldFont.copyWith(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                 selectedBook.volumeInfo.authors?.first ?? 'Unknown Author',
                  style: AppFonts.smallFont.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  '${selectedBook.saleInfo?.listPrice?.amount?.truncate() ?? 600} EGP',
                  style: AppFonts.boldFont.copyWith(
                    fontSize: 18,
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
