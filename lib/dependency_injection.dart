
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/resources/network_client.dart';
import 'features/home/data/data_sources/remote/home_api_service.dart';
import 'features/home/data/repository/home_repository_impl.dart';
import 'features/home/domain/repository/home_repository.dart';
import 'features/home/domain/usecases/get_home_item.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies()async{

  sl.registerFactory<Dio>(() => NetworkClient(Dio()).dio);

  sl.registerLazySingleton<HomeApiService>(()=> HomeApiService(dio: sl()));

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));


  sl.registerLazySingleton<GetHomeItemUseCase>(() => GetHomeItemUseCase(homeRepository: sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(getHomeItemUseCase: sl()));







}