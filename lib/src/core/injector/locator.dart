import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/authentication/data/datasource/auth_service.dart';
import 'package:gold_silver/src/features/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:gold_silver/src/features/authentication/domain/auth_repository.dart';
import 'package:gold_silver/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gold_silver/src/features/dashboard/data/datasource/dashboard_service.dart';
import 'package:gold_silver/src/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:gold_silver/src/features/dashboard/domain/dashboard_repository.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:gold_silver/src/features/forgot_password/data/datasource/password_service.dart';
import 'package:gold_silver/src/features/forgot_password/data/repository_impl/password_repository_impl.dart';
import 'package:gold_silver/src/features/forgot_password/domain/password_repository.dart';
import 'package:gold_silver/src/features/forgot_password/presentation/bloc/password_bloc.dart';
import 'package:gold_silver/src/features/news/data/datasource/news_service.dart';
import 'package:gold_silver/src/features/news/data/repository_impl/news_repository_impl.dart';
import 'package:gold_silver/src/features/news/domain/news_repository.dart';
import 'package:gold_silver/src/features/news/presentation/bloc/news_bloc.dart';

final GetIt locator = GetIt.instance;
final firebaseAuth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;

void setupLocator() {
  /// Register DioClient
  // locator.registerLazySingleton<DioClient>(() => DioClient());
  locator.registerLazySingleton<AlphaDioClient>(() => AlphaDioClient());
  locator.registerLazySingleton<GoldDioClient>(() => GoldDioClient());
  locator.registerLazySingleton<DojiDioClient>(() => DojiDioClient());
  locator.registerLazySingleton<NewsDioClient>(() => NewsDioClient());

  /// Register Dashboard services, repo, bloc
  locator.registerLazySingleton<DashboardService>(() => DashboardServiceImpl(
        alphaClient: locator<AlphaDioClient>(),
        goldClient: locator<GoldDioClient>(),
        dojiClient: locator<DojiDioClient>(),
      ));
  locator.registerLazySingleton<DashboardRepository>(() => DashboardServiceRepositoryImpl(locator<DashboardService>()));
  locator.registerFactory<DashboardBloc>(() => DashboardBloc(repository: locator<DashboardRepository>()));

  /// Register Auth services, repos, blocs
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  locator.registerLazySingleton<AuthRepository>(() => AuthServiceRepositoryImpl(locator<AuthService>()));
  locator.registerFactory<AuthBloc>(() => AuthBloc(repository: locator<AuthRepository>()));

  /// Register Password services, repos, blocs
  locator.registerLazySingleton<PasswordService>(() => PasswordServiceImpl());
  locator.registerLazySingleton<PasswordRepository>(() => PasswordServiceRepositoryImpl(locator<PasswordService>()));
  locator.registerFactory<PasswordBloc>(() => PasswordBloc(repository: locator<PasswordRepository>()));

  /// Register News services, repos, blocs
  locator.registerLazySingleton<NewsService>(() => NewsServiceImpl(locator<NewsDioClient>()));
  locator.registerLazySingleton<NewsRepository>(() => NewsServiceRepositoryImpl(locator<NewsService>()));
  locator.registerFactory<NewsBloc>(() => NewsBloc(repository: locator<NewsRepository>()));
}
