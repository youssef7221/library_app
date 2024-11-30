import 'package:library_app/Features/home/data/models/book_model/book_model.dart';
import 'package:library_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:library_app/Features/home/presentation/manger/smila_books_cubit/similar_books_cubit.dart';
import 'package:library_app/Features/home/presentation/views/book_details_view.dart';
import 'package:library_app/Features/home/presentation/views/home_view.dart';
import 'package:library_app/Features/login/presentation/view/login_screen.dart';
import 'package:library_app/Features/register/presentation/view/register_screen.dart';
import 'package:library_app/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../Features/Splash/presentation/splash_screen.dart';
import '../../../Features/home/seller_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static const kSellerView = '/sellerView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kSellerView,
        builder: (context, state) => const SellerView(),
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
          create: (context) => SimilarBooksCubit(
            getIt.get<HomeRepoImpl>(),
          ),
          child: BookDetailsView(
            bookModel: state.extra as BookModel,
          ),
        ),
      ),
    ],
  );
}
