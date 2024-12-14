import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/core/shared_cubits/user_books_hive/user_books_ld_cubit.dart';
import 'package:library_app/core/user_cubit/user_cubit.dart';
import 'package:library_app/core/user_cubit/user_state.dart';
import '../../../../../../core/service_locator/service_locator.dart';
import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../manager/data/models/book_model/book_model.dart';

class BuyNowWidget extends StatelessWidget {
  const BuyNowWidget({required this.selectedBook, super.key});

  final BookModel? selectedBook;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state1) {
            return BlocBuilder<UserBooksLdCubit, UserBooksLdState>(
              builder: (context, state2) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        final userBooksLdCubit =
                            context.read<UserBooksLdCubit>();
                        final userModelId =
                            context.read<UserCubit>().userModel?.id;
                        if (selectedBook != null) {
                          userBooksLdCubit.isBookMarked
                              ? userBooksLdCubit.deleteBook(
                                  selectedBook!.id, userModelId)
                              : userBooksLdCubit.saveBook(
                                  selectedBook, userModelId);
                        }
                      },
                      child: Icon(
                        Icons.bookmark,
                        color: context
                                .read<UserBooksLdCubit>()
                                .hiveService
                                .isBookSaved(
                                  context.read<UserCubit>().userModel!.id ?? '',
                                  selectedBook?.id ?? '',
                                )
                            ? AppColors.goldColor
                            : AppColors.blackColor,
                        size: 30,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          borderRadius: BorderRadius.circular(20)),
                      width: MediaQuery.of(context).size.width * .6,
                      child: Center(
                        child: Text(
                          "Buy Now for ${selectedBook?.saleInfo?.listPrice?.amount?.truncate()??600} EGP",
                          style: AppFonts.smallFont.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold),
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
