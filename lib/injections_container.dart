/* import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/core/network/network_info.dart';
import 'package:posts_app/features/posts/data/dataresources/local_datasource.dart';
import 'package:posts_app/features/posts/data/dataresources/remote_datasource.dart';
import 'package:posts_app/features/posts/data/respos/post_repo_imp.dart';
import 'package:posts_app/features/posts/domain/repos/post_repo.dart';
import 'package:posts_app/features/posts/domain/usercases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/get_all_posts_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/update_post_usecase.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/get_refresh/get_refresh_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//features - posts
  /// Bloc
  sl.registerFactory(() => GetRefreshBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdateBloc(
      addPostUseCase: sl(), deletePostUseCase: sl(), updatePostUseCase: sl()));

  /// UseCases
  sl.registerLazySingleton(() => AddPostUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetAllPostsUseCase(repo: sl()));

  /// Repos
  sl.registerLazySingleton<PostRepo>(() => PostRepoImp(
      remoteDatasource: sl(), localDatasource: sl(), networkInfo: sl()));

  /// DataResouces;
  sl.registerLazySingleton(() => RemoteDatasourceWithHttp(client: sl()));
  sl.registerLazySingleton(() => LocalDatasoucreImp(sharedPrefrences: sl()));

// core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(networkConnectionChecker: sl()));

// external
  final sharedPrefrences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefrences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
 */

import 'package:posts_app/features/posts/data/dataresources/local_datasource.dart';
import 'package:posts_app/features/posts/data/dataresources/remote_datasource.dart';
import 'package:posts_app/features/posts/data/respos/post_repo_imp.dart';
import 'package:posts_app/features/posts/domain/repos/post_repo.dart';
import 'package:posts_app/features/posts/domain/usercases/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/get_all_posts_usecase.dart';
import 'package:posts_app/features/posts/domain/usercases/update_post_usecase.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/get_refresh/get_refresh_bloc.dart';

import 'core/network/network_info.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
//final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => GetRefreshBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdateBloc(
      addPostUseCase: sl(), updatePostUseCase: sl(), deletePostUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(repo: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repo: sl()));

// Repository

  sl.registerLazySingleton<PostRepo>(() => PostRepoImp(
      remoteDatasource: sl(), localDatasource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<RemoteDatasource>(
      () => RemoteDatasourceWithHttp(client: sl()));
  sl.registerLazySingleton<LocalDatasource>(
      () => LocalDatasoucreImp(sharedPrefrences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(networkConnectionChecker: sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
