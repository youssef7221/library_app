import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/home/presentation/views/tabs/favourites_screen/widgets/book_details_row.dart';
import 'package:library_app/core/loading_overlay/loadingoverlay.dart';
import 'package:library_app/core/shared_cubits/user_books_hive/user_books_ld_cubit.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_cubit.dart';
import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserCubit>().userModel?.id;
    context.read<UserBooksLdCubit>().loadBooks(userId);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            // Header Row
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 24),
                  onPressed: () => Navigator.of(context).pop(),
                  color: AppColors.blackColor,
                ),
                const SizedBox(width: 10),
                Text(
                  "Favourites",
                  style: AppFonts.boldFont.copyWith(fontSize: 26),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // BlocBuilder for rendering states
            Expanded(
              child: BlocBuilder<UserBooksLdCubit, UserBooksLdState>(
                builder: (context, state) {
                  if (state is LoadingBooks) {
                    return LoadingOverlay();
                  } else if (state is UserBooksEmpty){
                    return Center(
                      child: Text(
                        "No books found in favourites.",
                        style: AppFonts.boldFont.copyWith(fontSize: 16),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.bookModel.length,
                      itemBuilder: (context, index) {
                        final book = state.bookModel[index];
                        return BookDetailsRow(selectedBook: book);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}