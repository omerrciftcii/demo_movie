import 'package:dartz/dartz.dart' as dartz;
import 'package:demo_movie/core/failures/failure.dart';
import 'package:demo_movie/features/search/domain/entities/movie.dart';
import 'package:demo_movie/features/search/domain/usecases/get_movie_detail.dart';
import 'package:demo_movie/features/search/presentation/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../dependency_injection.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imdbId;
  final String movieName;
  MovieDetailScreen({required this.imdbId, required this.movieName});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  GetMovieDetail getMovieDetail = sl<GetMovieDetail>();
  @override
  void initState() {
    var movieProvider = Provider.of<MoviesProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      movieProvider.movieDetailsFuture = getMovieDetail(
        GetMovieParameters(imdbId: widget.imdbId),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.chevron_left,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              flex: 1,
              child: Text(
                widget.movieName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: ListView(
                shrinkWrap: true,
                children: [
                  FutureBuilder<dartz.Either<Failure, Movie>>(
                    future: movieProvider.movieDetailsFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<dartz.Either<Failure, Movie>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasError == false) {
                        return snapshot.data!.fold(
                          (l) {
                            return const Center(
                              child: Text('An error occured'),
                            );
                          },
                          (r) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 37.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.network(
                                      r.poster == 'N/A'
                                          ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png'
                                          : r.poster ?? '',
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    r.title ?? '',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      r.director ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  // height: 500,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: r.ratings!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(
                                            r.ratings![index].source ?? ''),
                                        subtitle:
                                            Text(r.ratings![index].value ?? ''),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
