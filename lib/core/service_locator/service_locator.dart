import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:library_app/Features/home/manager/data/data_source/home_ds_impl.dart';
import 'package:library_app/Features/home/manager/domain/repos/home_repo.dart';
import 'package:library_app/Features/home/manager/domain/usecase/featured_books_use_case.dart';
import 'package:library_app/Features/home/manager/domain/usecase/small_featured_book_use_case.dart';
import 'package:library_app/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:library_app/Features/home/presentation/manger/smila_books_cubit/search_books_cubit.dart';
import 'package:library_app/core/navigation_cubit/navigation_cubit.dart';
import '../../Features/home/manager/data/data_source/home_ds.dart';
import '../../Features/home/manager/data/repos/home_repo_impl.dart';
import '../../Features/home/manager/domain/usecase/SearchBooksUseCase.dart';
import '../../Features/home/presentation/manger/search_books_cubit/search_books_cubit.dart';
import '../auth_cubit/auth_cubit.dart';
import '../auth_firebase/auth_firebase.dart';
import '../firebase_service/firebase_service.dart';
import '../password_cubit/password_cubit.dart';
import '../utils/api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AuthFirebase>(AuthFirebase());
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<HomeDs>(HomeDsImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<HomeRepo>
    (HomeRepoImpl(getIt.get<HomeDs>()));
  getIt.registerSingleton<FeaturedBooksUseCase>
    (FeaturedBooksUseCase(getIt.get<HomeRepo>()));
  getIt.registerSingleton<SearchBooksUseCase>
    (SearchBooksUseCase(getIt.get<HomeRepo>()));
  getIt.registerSingleton<SmallFeaturedBookUseCase>(
      SmallFeaturedBookUseCase(getIt.get<HomeRepo>()));
    (SearchBooksUseCase(getIt.get<HomeRepo>()));
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  getIt.registerFactory<PasswordCubit>(
    () => PasswordCubit(),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(),
  );
  getIt.registerFactory<NavigationCubit>(
    () => NavigationCubit(),
  );
  getIt.registerFactory<FeaturedBooksCubit>(
    () => FeaturedBooksCubit(),
  );
  getIt.registerFactory<SearchBooksCubit>(
        () => SearchBooksCubit(),
  );
}