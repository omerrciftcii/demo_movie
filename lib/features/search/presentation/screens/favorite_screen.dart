import 'package:demo_movie/features/search/data/models/movie_list_item_model.dart';
import 'package:demo_movie/features/search/domain/entities/movie.dart';
import 'package:demo_movie/features/search/domain/entities/movie_list_item.dart';
import 'package:demo_movie/features/search/presentation/providers/movie_provider.dart';
import 'package:demo_movie/features/search/presentation/widgets/movie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(
      context,
    );
    return movieProvider.favoriteMovies.length == 0
        ? const Center(
            child: Text('Your favorite list is empty'),
          )
        : Column(
            children: [
              SizedBox(
                height: 25,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: movieProvider.favoriteMovies.length,
                itemBuilder: (context, int index) {
                  return MovieListItemWidget(
                    movie: movieProvider.favoriteMovies[index],
                  );
                },
              ),
            ],
          );
  }
}
