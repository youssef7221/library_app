import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/utils/app_color.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final List<Widget> screens;
  final PersistentTabController? controller;
  final List<PersistentBottomNavBarItem> navBarsItems;
  const BottomNavBar({super.key, required this.screens, required this.controller,required this.navBarsItems});
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: screens,
      items: navBarsItems,
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: false, //
      // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      padding:  EdgeInsets.only(bottom: 8),
      backgroundColor:Colors.white,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: false,
      navBarHeight: 60,
      navBarStyle: NavBarStyle.style7, // Choose the nav bar style with this property
    );
  }
}


