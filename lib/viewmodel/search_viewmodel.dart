import 'package:flutter/material.dart';
import '../data/models/movie_model.dart';
import '../data/repository/movie_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final MovieRepository repository;

  SearchViewModel(this.repository);

  List<Movie> searchResults = [];
  bool isLoading = false;
  String? error;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      searchResults = [];
      error = null;
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      searchResults = await repository.searchMovies(query);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
