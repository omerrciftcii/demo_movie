import 'package:demo_movie/features/search/data/datasources/movies_datasource.dart';
import 'package:demo_movie/features/search/data/repositories/movie_repository_impl.dart';
import 'package:demo_movie/features/search/domain/repositories/movies_repository.dart';
import 'package:demo_movie/features/search/domain/usecases/search_movies.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network_info.dart';
import 'features/search/domain/usecases/get_movie_detail.dart';
final sl = GetIt.instance;

Future<void> initialize() async {
  sl.registerLazySingleton(() => http.Client());

//Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //Demo

  //Usecases
  sl.registerLazySingleton(
    () => SearchMovies(
      repository: sl(),
    ),
  );
    sl.registerLazySingleton(
    () => GetMovieDetail(
      repository: sl(),
    ),
  );

  //Repositories
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      datasource: sl(),
      networkInfo: sl(),
    ),
  );

  //Datasources
  sl.registerLazySingleton<MoviesDatasource>(
    () => MovieDatasourceImpl(
      client: sl(),
    ),
  );
}
