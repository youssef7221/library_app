import 'package:hive_flutter/hive_flutter.dart';
import 'package:library_app/Features/home/manager/domain/usecase/featured_books_use_case.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/core/hive_service/hive_service.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:library_app/core/shared_cubits/user_books_hive/user_books_ld_cubit.dart';
import 'package:library_app/core/user_cubit/user_cubit.dart';

import 'Features/home/manager/data/repos/home_repo_impl.dart';
import 'core/book_model/MyBookModelHive.dart';
import 'core/observer/my_bloc_observer.dart';
import 'core/router/app_router.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
 await getIt<HiveService>().initHive();
  runApp(const LibraryApp());
}
class LibraryApp extends StatefulWidget {
  const LibraryApp({super.key});
  @override
  State<LibraryApp> createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  @override
  void dispose(){
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => getIt<UserCubit>()..loadUser()),
        BlocProvider(
          create: (context) => getIt<FeaturedBooksCubit>()..fetchFeaturedBooks()
          ..fetchSmallFeaturedBooks(),
        ),
        BlocProvider(
            create: (context) => getIt<UserBooksLdCubit>()),
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
