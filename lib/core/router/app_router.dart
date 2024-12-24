import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/Features/home/presentation/views/account_screen/account_screen.dart';
import 'package:library_app/Features/home/presentation/views/book_details/book_details_screen.dart';
import 'package:library_app/Features/home/presentation/views/home_view.dart';
import 'package:library_app/Features/home/presentation/views/payment_screen/payment_methods_screen.dart';
import 'package:library_app/Features/home/presentation/views/tabs/my_books_screen/my_books_screen.dart';
import 'package:library_app/Features/login/presentation/view/login_screen.dart';
import 'package:library_app/Features/register/presentation/view/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/service_locator/service_locator.dart';
import 'package:library_app/core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../Features/Splash/presentation/splash_screen.dart';
import '../../Features/home/manager/data/models/book_model/book_model.dart';
import '../../Features/home/presentation/manger/search_books_cubit/search_books_cubit.dart';
import '../../Features/home/presentation/views/payment_screen/manager/payment_methods_cubit.dart';
import '../../Features/search_screen/search_screen.dart';
import '../shared_cubits/password_cubit/password_cubit.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kSearchView = '/searchView';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static const kHomeDetailsView = '/homeDetailsView';
  static const kPaymentView = '/paymentView';
  static const kMyBooksView = "/myBooksView";
  static const kAccountView = "/accountView";

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: kSearchView,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<SearchBooksCubit>(),
        child: SearchScreen(),
      ),
    ),
    GoRoute(
      path: kAccountView,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: AccountScreen(),
      ),
    ),
    GoRoute(
      path: kHomeView,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: kLoginView,
      builder: (context, state) => MultiBlocProvider(providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(
          create: (context) => getIt<PasswordCubit>(),
        ),
      ], child: LoginScreen()),
    ),
    GoRoute(
        path: kRegisterView,
        builder: (context, state) => MultiBlocProvider(providers: [
              BlocProvider(create: (context) => getIt<AuthCubit>()),
              BlocProvider(
                create: (context) => getIt<PasswordCubit>(),
              ),
            ], child: const RegisterScreen())),
    GoRoute(
      path: kMyBooksView,
      builder: (context, state) => const MyBooksScreen(),
    ),
    GoRoute(
      path: kPaymentView,
      builder: (context, state) {
        final BookModel selectedBook = state.extra as BookModel;
        return BlocProvider(
          create: (context) => getIt<PaymentMethodsCubit>(),
  child: PaymentMethodsScreen(selectedBook: selectedBook),
);
      },
    ),
    GoRoute(
        path: AppRouter.kHomeDetailsView,
        builder: (context, state) {
          final BookModel selectedBook = state.extra as BookModel;
          return BookDetailsScreen(selectedBook: selectedBook);
        })
  ]);
}
