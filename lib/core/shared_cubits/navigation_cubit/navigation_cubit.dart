import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:library_app/Features/home/presentation/views/tabs/favourites_screen/favourites_screen.dart';
import 'package:library_app/Features/home/presentation/views/tabs/home_screen/home_screen.dart';
import 'package:library_app/Features/home/presentation/views/tabs/my_books_screen/my_books_screen.dart';
import 'package:library_app/Features/home/presentation/views/tabs/settings_screen/settings_screen.dart';
import 'package:library_app/core/flutter_secure/flutter_secure.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:meta/meta.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../utils/app_color.dart';
import '../../utils/model/userdm.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());
  PersistentTabController? persistentTabController = PersistentTabController(initialIndex: 0);
  UserModel? userModel;
  Future<void> loadUserData() async {
    userModel = await storage.readData("user");
  }
  List<Widget> tabs = [
    HomeScreen(),
    const FavouritesScreen(),
    const MyBooksScreen(),
    const SettingsScreen()
  ];
 final storage = getIt<SecureStorageManager>();
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon:const Icon(Icons.home),
          title: ("Home") ,
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.blackColor,
          activeColorSecondary: Colors.white
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.favorite),
        title: ("Favourites"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.blackColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.library_books),
        title: ("My Books"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.blackColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
          icon:const Icon(Icons.settings),
          title: ("Settings"),
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.blackColor,
          activeColorSecondary: Colors.white
      ),
    ];
  }

}
