class MovieListItem {
  MovieListItem({
    this.search,
    this.totalResults,
    this.response,
  });

  List<Search>? search;
  String? totalResults;
  String? response;

  // factory MovieListItem.fromJson(Map<String, dynamic> json) => MovieListItem(
  //     search: List<Search>.from(json["Search"].map((x) => Search.fromJson(x))),
  //     totalResults: json["totalResults"],
  //     response: json["Response"],
  // );

  // Map<String, dynamic> toJson() => {
  //     "Search": List<dynamic>.from(search.map((x) => x.toJson())),
  //     "totalResults": totalResults,
  //     "Response": response,
  // };
}

class Search {
  Search({
    this.title,
    this.year,
    this.imdbId,
    this.type,
    this.poster,
  });

  String? title;
  String? year;
  String? imdbId;
  String? type;
  String? poster;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        title: json["Title"],
        year: json["Year"],
        imdbId: json["imdbID"],
        type: json["type"],
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

// enum Type { MOVIE, GAME }

// final typeValues = EnumValues({
//     "game": Type.GAME,
//     "movie": Type.MOVIE
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
