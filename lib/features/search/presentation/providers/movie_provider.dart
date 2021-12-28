import 'package:dartz/dartz.dart';
import 'package:demo_movie/core/failures/failure.dart';
import 'package:demo_movie/features/search/domain/entities/movie.dart';
import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';
import 'package:demo_movie/features/search/domain/usecases/search_movies.dart';
import 'package:demo_movie/features/search/presentation/screens/favorite_screen.dart';
import 'package:demo_movie/features/search/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';

import '../../../../dependency_injection.dart';

class MoviesProvider extends ChangeNotifier {
  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  set isWaiting(value) {
    _isWaiting = value;
    notifyListeners();
  }

  SearchMovies searchMovieUsecase = sl<SearchMovies>();
  Future<Either<Failure, Movie>>? _movieDetailsFuture;
  Future<Either<Failure, Movie>>? get movieDetailsFuture => _movieDetailsFuture;
  set movieDetailsFuture(value) {
    _movieDetailsFuture = value;
    notifyListeners();
  }

  List<Search>? _movieList;
  List<Search>? get movieList => _movieList;
  set movieList(value) {
    _movieList = value;
    notifyListeners();
  }

  ServerFailure? _failure;
  ServerFailure? get failure => _failure;
  set failure(value) {
    _failure = value;
    notifyListeners();
  }

  List<Widget> screens = [
    SearchWidget(),
    FavoriteScreen(),
  ];
  int _bottomNavigationBarCurrentIndex = 0;
  int get bottomNavigationBarCurrentIndex => _bottomNavigationBarCurrentIndex;
  set bottomNavigationBarCurrentIndex(value) {
    _bottomNavigationBarCurrentIndex = value;
    notifyListeners();
  }

  Future<void> searchMovies({required String queryString}) async {
    isWaiting = true;

    var response = await searchMovieUsecase(
      SearchParameters(queryString: queryString),
    );
    response.fold((l) {
      failure = l;
      isWaiting = false;
    }, (r) {
      movieList = r.search;
      failure = null;
      isWaiting = false;
    });
  }

  List<Search> _favoriteMovies = [];

  List<Search> get favoriteMovies => _favoriteMovies;
  set favoriteMovies(value) {
    _favoriteMovies = value;
    notifyListeners();
  }

  TextEditingController _searchController = TextEditingController(text: '');

  void addMovieToFavorites({required Search movie}) {
    if (favoriteMovies.contains(movie)) {
      favoriteMovies.remove(movie);
    } else {
      favoriteMovies.add(movie);
    }
    notifyListeners();
  }

  TextEditingController get searchController => _searchController;
}
