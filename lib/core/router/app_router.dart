import 'package:library_app/Features/home/presentation/views/book_details/book_details_screen.dart';
import 'package:library_app/Features/home/presentation/views/home_view.dart';
import 'package:library_app/Features/login/presentation/view/login_screen.dart';
import 'package:library_app/Features/register/presentation/view/register_screen.dart';
import 'package:go_router/go_router.dart';
import '../../../Features/Splash/presentation/splash_screen.dart';
import '../../Features/home/manager/data/models/book_model/book_model.dart';
import '../../Features/search_screen/search_screen.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kSearchView = '/searchView';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static const kHomeDetailsView = '/homeDetailsView';
  static final router = GoRouter(routes: [
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
        path: AppRouter.kHomeDetailsView,
        builder: (context, state) {
          final BookModel selectedBook = state.extra as BookModel;
          return BookDetailsScreen(selectedBook: selectedBook);
        })
  ]);
}
