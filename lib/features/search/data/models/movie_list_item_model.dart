import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';

class MovieListItemModel extends MovieListItem {
  MovieListItemModel({
    List<Search>? search,
    String? totalResults,
    String? response,
  }) : super(search: search, totalResults: totalResults, response: response);

  factory MovieListItemModel.fromJson(Map<String, dynamic> json) =>
      MovieListItemModel(
        search: json["Response"] == 'False'
            ? []
            : List<Search>.from(json["Search"].map((x) => Search.fromJson(x))),
        totalResults: json["totalResults"],
        response: json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Search": List<dynamic>.from(search!.map((x) => x.toJson())),
        "totalResults": totalResults,
        "Response": response,
      };
}

class SearchModel extends Search {
  SearchModel({
    String? title,
    String? year,
    String? imdbId,
    String? type,
    String? poster,
  }) : super(title: title, year: year, imdbId: imdbId, type: type);

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        type: json["Type"],
        poster: json["Poster"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "imdbID": imdbId,
        // "Type": typeValues.reverse[type],
        "Poster": poster,
      };
}
