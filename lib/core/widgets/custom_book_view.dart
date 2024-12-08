import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:library_app/core/router/app_router.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:library_app/core/utils/app_fonts.dart';

import '../../Features/home/manager/data/models/book_model/book_model.dart';

class CustomBookView extends StatelessWidget {
  const CustomBookView({required this.books,required this.width, required this.index, super.key});
  final double? width;
  final BookModel? books;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoRouter.of(context).push(AppRouter.kHomeDetailsView,extra:books),
      child: SizedBox(
        width: 120,
        child:Column(
          children:[
            Hero(
              tag: "thumbnail${books?.id}",
              child: CustomBookImage(
                imageUrl: books?.volumeInfo.imageLinks?.thumbnail ?? '',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              books?.volumeInfo.title ?? "",
              style: AppFonts.bookFont,
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "3.7",
                  style: AppFonts.smallFont.copyWith(color: AppColors.blackColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  size: 16,
                ),
                SizedBox(
                  width: 3,
                ),
                Spacer(),
                Text(
                  "${books?.saleInfo?.listPrice?.amount?.truncate() ?? "600"} Egp",
                  style: AppFonts.smallFont.copyWith(color: AppColors.blackColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
