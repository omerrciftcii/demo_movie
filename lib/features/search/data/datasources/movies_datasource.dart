import 'dart:convert';

import 'package:demo_movie/common/constants/api_constantants.dart';
import 'package:demo_movie/features/search/data/models/movie_list_item_model.dart';
import 'package:demo_movie/features/search/data/models/movie_model.dart';
import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';
import 'package:http/http.dart' as http;

abstract class MoviesDatasource {
  Future<MovieModel> getMovieDetails({required String imdbId});
  Future<MovieListItem> searchMovies({required String searchParameters});
}

class MovieDatasourceImpl implements MoviesDatasource {
  final http.Client client;
  MovieDatasourceImpl({required this.client});

  @override
  Future<MovieModel> getMovieDetails({required String imdbId}) async {
    final queryParameters = {
      'i': imdbId,
      'apikey': apiKey,
    };
    try {
      final uri = Uri.http(baseUrl, '/', queryParameters);
      final response = await client.get(uri);

      return MovieModel.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<MovieListItem> searchMovies({required String searchParameters}) async {
    final queryParameters = {
      's': searchParameters,
      'apikey': apiKey,
    };
    try {
      final uri = Uri.http(baseUrl, '/', queryParameters);
      final response = await client.get(uri);

      return MovieListItemModel.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
