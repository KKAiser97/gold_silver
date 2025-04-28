import 'package:get_it/get_it.dart';
import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/dashboard/data/datasource/dashboard_service.dart';
import 'package:gold_silver/src/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:gold_silver/src/features/dashboard/domain/dashboard_repository.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  /// Register DioClient
  // locator.registerLazySingleton<DioClient>(() => DioClient());
  locator.registerLazySingleton<AlphaDioClient>(() => AlphaDioClient());
  locator.registerLazySingleton<GoldDioClient>(() => GoldDioClient());
  locator.registerLazySingleton<DojiDioClient>(() => DojiDioClient());

  /// Register Dashboard services, repo, bloc
  locator.registerLazySingleton<DashboardService>(() => DashboardServiceImpl(
        alphaClient: locator<AlphaDioClient>(),
        goldClient: locator<GoldDioClient>(),
        dojiClient: locator<DojiDioClient>(),
      ));
  locator.registerLazySingleton<DashboardRepository>(() => DashboardServiceRepositoryImpl(locator<DashboardService>()));
  locator.registerFactory<DashboardBloc>(() => DashboardBloc(repository: locator<DashboardRepository>()));
}
