import 'package:get_it/get_it.dart';
import 'package:gold_silver/src/core/client/dio_client.dart';
import 'package:gold_silver/src/features/dashboard/data/datasource/dashboard_service.dart';
import 'package:gold_silver/src/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:gold_silver/src/features/dashboard/domain/dashboard_repository.dart';
import 'package:gold_silver/src/features/dashboard/presentation/bloc/dashboard_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register DioClient
  locator.registerLazySingleton<DioClient>(() => DioClient());

  // Register Dashboard services, repo, bloc
  locator.registerLazySingleton<DashboardService>(() => DashboardServiceImpl(locator<DioClient>()));
  locator.registerLazySingleton<MetalRepository>(() => DashboardServiceRepositoryImpl(locator<DashboardService>()));
  locator.registerFactory<DashboardBloc>(() => DashboardBloc(repository: locator<MetalRepository>()));
}
