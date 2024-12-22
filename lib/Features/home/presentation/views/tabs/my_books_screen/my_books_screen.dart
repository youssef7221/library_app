import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/loading_overlay/loadingoverlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_cubit.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_state.dart';
import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import 'widgets/custom_my_book_view.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  bool _hasLoadedBooks = false;
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().loadOwnedBooks(context);
    _hasLoadedBooks = true;
  }
  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  "My Books",
                  style: AppFonts.boldFont.copyWith(fontSize: 26.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is LoadingBooks) {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.blackColor,
                        size: 40,
                      ),
                    );
                  }else if (userCubit.ownedBooks.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 9 / 16,
                        mainAxisSpacing: 10,
                      ),
                      padding: EdgeInsets.zero,
                      itemCount: userCubit.ownedBooks.length,
                      itemBuilder: (context, index) {
                        final book = userCubit.ownedBooks[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: CustomMyBookView(
                            book: book,
                          ),
                        );
                      },
                    );
                  } else if (state is UserError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: AppFonts.boldFont.copyWith(fontSize: 16.sp),
                      ),
                    );
                  }  else if (userCubit.ownedBooks.isEmpty) {
                    return Center(
                      child: Text(
                        "No books found in My Books.",
                        style: AppFonts.boldFont.copyWith(fontSize: 16.sp),
                      ),
                    );
                  }
                  else {
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
