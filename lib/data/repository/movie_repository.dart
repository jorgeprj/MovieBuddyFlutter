import '../models/movie_model.dart';
import '../services/tmdb_api_service.dart';
import 'package:primeiro_app/db/movie_database.dart';
import 'package:primeiro_app/db/movie_entity.dart';

class MovieRepository {
  final TmdbApiService apiService;
  final MovieDatabase database;

  MovieRepository(this.apiService, this.database);

  // API
  Future<List<Movie>> getPopularMovies() {
    return apiService.fetchPopularMovies();
  }

  Future<List<Movie>> getLatestMovies() {
    return apiService.fetchLatestMovies();
  }

  Future<List<Movie>> searchMovies(String query) {
    return apiService.searchMovies(query);
  }

  // FAVORITOS - DB
  Future<List<Movie>> getFavoriteMovies() async {
    final favorites = await database.movieDao.findAllFavorites();
    return favorites.map((e) => e.toMovieModel()).toList();
  }

  Future<bool> isFavorite(int id) async {
    final movie = await database.movieDao.findFavoriteById(id);
    return movie != null;
  }

  Future<void> addFavorite(Movie movie) async {
    final entity = MovieEntity.fromMovieModel(movie);
    await database.movieDao.insertFavorite(entity);
  }

  Future<void> removeFavorite(Movie movie) async {
    final entity = MovieEntity.fromMovieModel(movie);
    await database.movieDao.deleteFavorite(entity);
  }
}
