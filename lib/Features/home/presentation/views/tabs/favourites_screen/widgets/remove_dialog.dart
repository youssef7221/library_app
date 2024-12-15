import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/utils/app_color.dart';

import '../../../../../../../core/shared_cubits/user_books_hive/user_books_ld_cubit.dart';
import '../../../../../../../core/shared_cubits/user_cubit/user_cubit.dart';
import '../../../../../../../core/utils/app_fonts.dart';

class RemoveDialog {
 static void showRemoveBookDialog(BuildContext context, String? bookId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Remove Book',
          style: AppFonts.boldFont,
        ),
        content: Text(
          'Are you sure you want to remove this book from favourites?',
          style: AppFonts.smallFont,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: AppFonts.smallFont.copyWith(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.redColor),
            onPressed: () {
              context.read<UserBooksLdCubit>().deleteBook(
                bookId,
                context.read<UserCubit>().userModel?.id,
              );
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              'Remove',
              style: AppFonts.boldFont.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
