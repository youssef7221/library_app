import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_cubit.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_state.dart';
import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../manager/data/models/book_model/book_model.dart';

class BuyNowWidget extends StatelessWidget {
  const BuyNowWidget({required this.selectedBook, super.key});

  final BookModel? selectedBook;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.r, // Use ScreenUtil to make elevation responsive
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state1) {
            return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
              builder: (context, state2) {
                if (state2 is FetchBookLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blackColor,
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        final userModelCubit = context.read<UserCubit>();
                        final userModel =
                            context.read<UserCubit>().userModel?.id;
                        if (selectedBook != null){
                          userModelCubit.isBookMarked
                              ? userModelCubit.deleteBook(
                              selectedBook!.id, userModel)
                              : userModelCubit.saveBook(
                              selectedBook, userModel);
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: context
                            .read<UserCubit>()
                            .hiveService
                            .isBookSaved(
                          context.read<UserCubit>().userModel!.id ?? '',
                          selectedBook?.id ?? '',
                        )
                            ? AppColors.redColor
                            : AppColors.blackColor,
                        size: 30.r,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<FeaturedBooksCubit>()
                            .fetchSpecificBook(selectedBook!.id);
                        BookModel bookModel =
                            context.read<FeaturedBooksCubit>().bookModel;
                        GoRouter.of(context)
                            .push(AppRouter.kPaymentView, extra: bookModel);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        width: MediaQuery.of(context).size.width * .6,
                        child: Center(
                          child: Text(
                            "Buy Now for ${selectedBook?.saleInfo?.listPrice?.amount?.truncate() ?? 600} EGP",
                            style: AppFonts.smallFont.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
