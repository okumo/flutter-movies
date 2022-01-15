import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: moviesProvider.onDisplayMovies,
            ),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              onNextPage: () => moviesProvider.getPopularMovies(),
              title: "Populares",
            ),
          ],
        ),
      )),
    );
  }
}
