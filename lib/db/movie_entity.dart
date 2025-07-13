import 'package:floor/floor.dart';
import 'package:primeiro_app/data/models/movie_model.dart';

@Entity(tableName: 'favorite_movies')
class MovieEntity {
  @primaryKey
  final int id;

  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  factory MovieEntity.fromMovieModel(movie) => MovieEntity(
    id: movie.id,
    title: movie.title,
    overview: movie.overview,
    posterPath: movie.posterPath,
    releaseDate: movie.releaseDate,
  );

  Movie toMovieModel() => Movie(
    id: id,
    title: title,
    overview: overview,
    posterPath: posterPath,
    releaseDate: releaseDate,
  );
}
