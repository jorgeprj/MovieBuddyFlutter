import 'package:flutter/material.dart';
import '../data/models/movie_model.dart';
import '../data/repository/movie_repository.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieRepository repository;

  MovieViewModel(this.repository);

  List<Movie> popularMovies = [];
  List<Movie> latestMovies = [];
  List<Movie> favoriteMovies = [];
  bool isLoading = false;
  String? error;

  Future<void> loadMovies() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      popularMovies = await repository.getPopularMovies();
      latestMovies = await repository.getLatestMovies();
      await loadFavoriteMovies();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavoriteMovies() async {
    try {
      favoriteMovies = await repository.getFavoriteMovies();
      notifyListeners();
    } catch (e) {
      // opcional: tratar erro
    }
  }
}
