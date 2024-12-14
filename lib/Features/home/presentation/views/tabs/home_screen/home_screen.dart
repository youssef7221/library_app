import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/user_cubit/user_cubit.dart';
import 'package:library_app/core/user_cubit/user_state.dart';
import 'package:library_app/core/utils/app_fonts.dart';
import 'package:library_app/core/utils/model/userdm.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/flutter_secure/flutter_secure.dart';
import '../../widgets/custom_app_bar.dart';
import 'widgets/featured_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key});



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers:[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15),
            child: BlocBuilder<UserCubit, UserState>(
  builder: (context, state) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                CustomAppBar(),
                Text("New Books ya ${context.read<UserCubit>().userModel?.name}",style: AppFonts.boldFont,),
                SizedBox(height:10),
                FeaturedBooksListView(books:context.read<FeaturedBooksCubit>().featuredBooks,),
                Text(
                  'Pocket Books',
                  style: AppFonts.boldFont,
                ),
                SizedBox(
                  height: 10,
                ),
                FeaturedBooksListView(books:context.read<FeaturedBooksCubit>().smallFeaturedBooks),
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
