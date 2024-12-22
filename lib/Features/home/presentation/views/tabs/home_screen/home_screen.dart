import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/shared_cubits/user_cubit/user_cubit.dart';
import '../../../../../../core/shared_cubits/user_cubit/user_state.dart';
import 'widgets/custom_home_app_bar.dart';
import 'widgets/featured_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHomeAppBar(),
                    Text(
                      "New Books",
                      style: AppFonts.boldFont,
                    ),
                    SizedBox(height: 10.h),
                    FeaturedBooksListView(
                      books: context.read<FeaturedBooksCubit>().featuredBooks,
                    ),
                    Text(
                      'Pocket Books',
                      style: AppFonts.boldFont,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    FeaturedBooksListView(
                        books: context
                            .read<FeaturedBooksCubit>()
                            .smallFeaturedBooks),
                  ],
                );
              },
            ),
          ),
        ),
        // SliverFillRemaining(
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 30),
        //     child: BestSellerListView(),
        //   ),
        // ),
      ],
    );
  }
}
