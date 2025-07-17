import 'package:flutter/material.dart';
import 'package:primeiro_app/core/localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../viewmodel/movie_viewmodel.dart';
import '../data/models/movie_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MovieViewModel movieViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
    movieViewModel.loadFavoriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    movieViewModel = Provider.of<MovieViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: movieViewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : movieViewModel.error != null
              ? Center(child: Text('Erro: ${movieViewModel.error}'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (movieViewModel.favoriteMovies.isNotEmpty) ...[
                        SectionTitle(title: AppLocalizations.of(context)!.favoriteMovies),
                        MovieList(movies: movieViewModel.favoriteMovies),
                        SizedBox(height: 16), 
                      ],
                      SectionTitle(title: AppLocalizations.of(context)!.popularMovies),
                      MovieList(movies: movieViewModel.popularMovies),
                      SizedBox(height: 16),
                      SectionTitle(title: AppLocalizations.of(context)!.latestMovies),
                      MovieList(movies: movieViewModel.latestMovies),
                    ],
                  ),
                ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  const MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/details', arguments: movie)
                    .then((_) {
                  // Recarrega favoritos quando volta da DetailsPage
                  Provider.of<MovieViewModel>(context, listen: false)
                      .loadFavoriteMovies();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.network(
                        movie.fullPosterPath,
                        width: 120,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 120,
                      child: Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
