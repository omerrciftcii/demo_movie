import 'package:demo_movie/features/search/domain/entities/movie.dart';
import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';
import 'package:demo_movie/features/search/presentation/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieListItemWidget extends StatelessWidget {
  final Search? movie;
  MovieListItemWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(context);
    return ListTile(
      leading: Image.network(movie!.poster ?? ''),
      title: Text(movie!.title ?? ''),
      subtitle: Text(movie!.year ?? ''),
      trailing: GestureDetector(
        onTap: () {
          movieProvider.addMovieToFavorites(movie: movie ?? Search());
        },
        child: const Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
    );
  }
}
