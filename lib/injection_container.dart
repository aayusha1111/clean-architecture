import 'package:clean_architecture/core/network/api_client.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/core/storage/secure_storage.dart';
import 'package:clean_architecture/features/product/data/datasources/product_datasource.dart';
import 'package:clean_architecture/features/product/data/datasources/product_datassource_impl.dart';
import 'package:clean_architecture/features/product/domain/repository/product_repo.dart';
import 'package:clean_architecture/features/product/domain/repository/product_repo_impl.dart';
import 'package:clean_architecture/features/product/domain/usecase/fetch_product_usecase.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture/features/users/data/datasoucres/user_remote_datasource_impl.dart';
import 'package:clean_architecture/features/users/data/datasoucres/user_remote_datasources.dart';
import 'package:clean_architecture/features/users/domain/repository/user_repo.dart';
import 'package:clean_architecture/features/users/domain/repository/user_repo_impl.dart';
import 'package:clean_architecture/features/users/domain/usecase/post_user_usecase.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future registerDepnedenices() async {
  // registering external packages
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  //core services
  sl.registerLazySingleton<SecurePref>(
    () => SecurePref(storage: sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl<Dio>(), securePref: sl<SecurePref>()),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  //datasources
  sl.registerLazySingleton<ProductDatasource>(
    () => ProductDatassourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(sl<ApiClient>()),
  );


  //repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductDatasource>(), sl<NetworkInfo>()),
  );
  sl.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(sl<UserRemoteDatasource>(), sl<NetworkInfo>()),
  );

  //usecases
  sl.registerLazySingleton<FetchProductUsecase>(
    () => FetchProductUsecase(sl<ProductRepository>()),
  );

  sl.registerLazySingleton<PostUserUsecase>(
    () => PostUserUsecase(sl<UserRepo>()),
  );

  sl.registerLazySingleton<FetchUserUsecase>(
    () => FetchUserUsecase(sl<UserRepo>()),
  );

  sl.registerLazySingleton<UpdateUserUsecase>(()=>UpdateUserUsecase(sl<UserRepo>())
  );
  //other usecases can be registered here

  //blocs
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl<FetchProductUsecase>()));
  sl.registerFactory<UserBloc>(
    () => UserBloc(sl<PostUserUsecase>(), sl<FetchUserUsecase>(), sl<UpdateUserUsecase>()),
  );
}
