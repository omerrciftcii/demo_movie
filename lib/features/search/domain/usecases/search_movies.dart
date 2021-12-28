import 'package:dartz/dartz.dart';
import 'package:demo_movie/core/failures/failure.dart';
import 'package:demo_movie/core/usecase.dart';
import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';
import 'package:demo_movie/features/search/domain/repositories/movies_repository.dart';
import 'package:http/http.dart';

class SearchMovies implements UseCase<MovieListItem, SearchParameters> {
  final MoviesRepository repository;
  SearchMovies({required this.repository});

  @override
  Future<Either<Failure, MovieListItem>> call(params) async {
    return await repository.searchMovies(searchParameters: params.queryString);
  }
}

class SearchParameters {
  final String queryString;
  SearchParameters({required this.queryString});
}
