import 'package:library_app/Features/home/manager/domain/usecase/featured_books_use_case.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Features/home/manager/data/repos/home_repo_impl.dart';
import 'core/observer/my_bloc_observer.dart';
import 'core/router/app_router.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  runApp(const library_app());
}

class library_app extends StatelessWidget {
  const library_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit()..fetchFeaturedBooks()
          ..fetchSmallFeaturedBooks(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor:Colors.white.withOpacity(0.99),
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
