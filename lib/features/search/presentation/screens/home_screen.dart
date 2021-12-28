import 'package:demo_movie/core/providers/theme_provider.dart';
import 'package:demo_movie/dependency_injection.dart';
import 'package:demo_movie/features/search/domain/usecases/search_movies.dart';
import 'package:demo_movie/features/search/presentation/providers/movie_provider.dart';
import 'package:demo_movie/features/search/presentation/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? preferences;

  SearchMovies? searchMovies;
  @override
  void initState() {
    searchMovies = sl<SearchMovies>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MoviesProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavigationBarWidget(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            preferences = await SharedPreferences.getInstance();
            var theme = preferences!.getString('theme');
            if (theme == null || theme == 'light') {
              themeProvider.setDarkTheme();
              preferences!.setString('theme', 'dark');
            } else {
              themeProvider.setLightTheme();
              preferences!.setString('theme', 'light');
            }
          },
          child: Icon(Icons.edit_road_outlined),
        ),
        body: movieProvider
            .screens[movieProvider.bottomNavigationBarCurrentIndex],
      ),
    );
  }
}
