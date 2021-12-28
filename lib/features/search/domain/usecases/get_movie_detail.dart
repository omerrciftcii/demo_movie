import 'package:demo_movie/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_movie/core/usecase.dart';
import 'package:demo_movie/features/search/domain/entities/movie.dart';
import 'package:demo_movie/features/search/domain/repositories/movies_repository.dart';

class GetMovieDetail extends UseCase<Movie, GetMovieParameters> {
  final MoviesRepository repository;
  GetMovieDetail({required this.repository});
  @override
  Future<Either<Failure, Movie>> call(params) async {
    return await repository.getMovieDetails(imdbId: params.imdbId);
  }
}

class GetMovieParameters {
  final String imdbId;
  GetMovieParameters({required this.imdbId});
}
