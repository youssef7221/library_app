import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:library_app/Features/home/presentation/views/tabs/favourites_screen/favourites_screen.dart';
import 'package:library_app/Features/home/presentation/views/tabs/home_screen/home_screen.dart';
import 'package:library_app/Features/home/presentation/views/tabs/settings_screen/settings_screen.dart';
import 'package:meta/meta.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../utils/app_color.dart';
import '../utils/app_string.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());
  PersistentTabController? persistentTabController = PersistentTabController(initialIndex: 0);
  List<Widget> tabs = const[
    HomeScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon:const Icon(Icons.home),
          title: ("lolo") ,
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.blackColor,
          activeColorSecondary: Colors.white
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.favorite),
        title: ("vini"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.blackColor,
        activeColorSecondary: Colors.white,
      ),
      PersistentBottomNavBarItem(
          icon:const Icon(Icons.favorite),
          title: ("A7a"),
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.blackColor,
          activeColorSecondary: Colors.white
      ),
    ];
  }

}
