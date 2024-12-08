import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:library_app/core/navigation_cubit/navigation_cubit.dart';
import 'package:library_app/core/service_locator/service_locator.dart';

import '../../../../core/widgets/bottom_navbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: BlocProvider(create: (context) => getIt<NavigationCubit>(),
      child: BlocBuilder<NavigationCubit,NavigationState>
        (builder: (context, state) {
        return BottomNavBar(screens: context.watch<NavigationCubit>().tabs,
            controller: context.read<NavigationCubit>().persistentTabController,
            navBarsItems: context.read<NavigationCubit>().navBarsItems());
      },),),
    );
  }
}
