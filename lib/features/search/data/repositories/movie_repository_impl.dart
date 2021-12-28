import 'package:demo_movie/core/network_info.dart';
import 'package:demo_movie/features/search/data/datasources/movies_datasource.dart';
import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';
import 'package:demo_movie/features/search/domain/entities/movie.dart';
import 'package:demo_movie/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_movie/features/search/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final NetworkInfo networkInfo;
  final MoviesDatasource datasource;
  MoviesRepositoryImpl({
    required this.datasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Movie>> getMovieDetails(
      {required String imdbId}) async {
    if (await networkInfo.isConnected) {
      try {
        final dataSourceResponse =
            await datasource.getMovieDetails(imdbId: imdbId);
        return Right(dataSourceResponse);
      } catch (e) {
        return Left(
          ServerFailure(
            errorMessage: e.toString(),
          ),
        );
      }
    } else {
      return Left(
        ServerFailure(errorMessage: 'İnternet bağlantı hatası'),
      );
    }
  }

  @override
  Future<Either<ServerFailure, MovieListItem>> searchMovies(
      {required String searchParameters}) async {
    try {
      if (await networkInfo.isConnected) {
        final dataSource =
            await datasource.searchMovies(searchParameters: searchParameters);
        return Right(dataSource);
      } else {
        return Left(
          ServerFailure(
            errorMessage: 'Check your internet  connection',
          ),
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
