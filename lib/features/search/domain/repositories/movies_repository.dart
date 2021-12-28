import 'package:dartz/dartz.dart';
import 'package:demo_movie/core/failures/failure.dart';
import 'package:demo_movie/features/search/domain/entities/movie.dart';
import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';

abstract class MoviesRepository {
  Future<Either<Failure, MovieListItem>> searchMovies(
      {required String searchParameters});

  Future<Either<Failure, Movie>> getMovieDetails({required String imdbId});
}
