import 'package:library_app/Features/home/presentation/manger/smila_books_cubit/search_books_cubit.dart';
import 'package:library_app/Features/home/presentation/views/book_details_view.dart';
import 'package:library_app/Features/home/presentation/views/home_view.dart';
import 'package:library_app/Features/login/presentation/view/login_screen.dart';
import 'package:library_app/Features/register/presentation/view/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Features/Splash/presentation/splash_screen.dart';
import '../../Features/home/manager/data/models/book_model/book_model.dart';
import '../../Features/home/presentation/manger/search_books_cubit/search_books_cubit.dart';
import '../../Features/search_screen/search_screen.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) =>BlocProvider(
          create: (context) => SearchBooksCubit(),
          child: BookDetailsView(
            bookModel: state.extra as BookModel,
          ),
        ),
      ),
    ],
  );
}
