import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/utils/app_fonts.dart';
import 'package:library_app/core/utils/model/userdm.dart';
import 'package:library_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/flutter_secure/flutter_secure.dart';
import '../../widgets/custom_app_bar.dart';
import 'widgets/featured_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = const FlutterSecureStorage();
  UserModel? userModel ;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  Future<void> _loadUserData() async {
    userModel = await SecureStorageManager().readData("user");
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers:[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                CustomAppBar(),
                Text("New Books",style: AppFonts.boldFont,),
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
