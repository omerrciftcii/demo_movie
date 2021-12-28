import 'package:demo_movie/features/search/domain/usecases/search_movies.dart';
import 'package:demo_movie/features/search/presentation/providers/movie_provider.dart';
import 'package:demo_movie/features/search/presentation/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../dependency_injection.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);
  SearchMovies searchMovies = sl<SearchMovies>();
  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Expanded(
          flex: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 37),
            child: TextField(
              onSubmitted: (text) async {
                await movieProvider.searchMovies(queryString: text);
                movieProvider.failure != null
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Something went wrong'),
                            content: Text(movieProvider.failure?.errorMessage ??
                                'Unknown Error'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await movieProvider.searchMovies(
                                      queryString: text);
                                  if (movieProvider.failure == null) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Try Again'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        })
                    : print('');
              },
              onChanged: (text) {
                // movieProvider.searchMovieFuture = searchMovies!(
                //   SearchParameters(queryString: text),
                // );
              },
              controller: movieProvider.searchController,
              decoration: const InputDecoration(
                  filled: true,
                  // fillColor: Colors.white,
                  hintText: 'Search Movie!'),
            ),
          ),
        ),
        movieProvider.isWaiting
            ? Expanded(
                flex: 90, child: Center(child: CircularProgressIndicator()))
            : movieProvider.movieList == null
                ? const Expanded(
                    flex: 90,
                    child: Center(
                      child: Text('Start search movies!'),
                    ))
                : movieProvider.movieList!.isEmpty
                    ? const Expanded(
                        flex: 90,
                        child: Center(
                          child: Text('There is no result '),
                        ))
                    : Expanded(
                        flex: 90,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: movieProvider.movieList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.network(
                                movieProvider.movieList![index].poster == 'N/A'
                                    ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'
                                    : movieProvider.movieList![index].poster ??
                                        '',
                                height: 60,
                                width: 60,
                              ),
                              title: Text(
                                  movieProvider.movieList![index].title ??
                                      'Unknown',
                                  style: const TextStyle()),
                              subtitle: Row(
                                children: [
                                  Text(movieProvider.movieList![index].year ??
                                      's'),
                                ],
                              ),
                              trailing: GestureDetector(
                                child: Icon(
                                  Icons.favorite,
                                  color: movieProvider.favoriteMovies.contains(
                                          movieProvider.movieList![index])
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onTap: () {
                                  movieProvider.addMovieToFavorites(
                                      movie: movieProvider.movieList![index]);
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MovieDetailScreen(
                                      imdbId: movieProvider
                                              .movieList![index].imdbId ??
                                          '',
                                      movieName: movieProvider
                                              .movieList![index].title ??
                                          '',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
      ],
    );
  }
}
