import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_cubit.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_state.dart';
import '../../../../../../core/utils/app_fonts.dart';
import 'widgets/book_details_row.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  bool _hasLoadedFavourites = false;

  @override
  void initState() {
    super.initState();
    // Ensure favourite books are loaded only once
    if (!_hasLoadedFavourites) {
      context.read<UserCubit>().loadFavouriteBooks();
      _hasLoadedFavourites = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        child: Column(
          children: [
            // Header Row
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  "Favourites",
                  style: AppFonts.boldFont.copyWith(fontSize: 26.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // BlocBuilder for rendering states
            Expanded(
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is LoadingBooks) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (userCubit.favouritesBooks.isNotEmpty) {
                    return ListView.builder(
                      itemCount: userCubit.favouritesBooks.length,
                      itemBuilder: (context, index) {
                        final book = userCubit.favouritesBooks[index];
                        return BookDetailsRow(selectedBook: book);
                      },
                    );
                  } else if (state is UserError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: AppFonts.boldFont.copyWith(fontSize: 16.sp),
                      ),
                    );
                  } else if (userCubit.favouritesBooks.isEmpty) {
                    return Center(
                      child: Text(
                        "No books found in favourites.",
                        style: AppFonts.boldFont.copyWith(fontSize: 16.sp),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Something went wrong.",
                        style: AppFonts.boldFont.copyWith(fontSize: 16.sp),
                      ),
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
