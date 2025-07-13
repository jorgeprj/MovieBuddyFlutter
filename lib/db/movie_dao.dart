import 'package:floor/floor.dart';
import 'movie_entity.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM favorite_movies')
  Future<List<MovieEntity>> findAllFavorites();

  @Query('SELECT * FROM favorite_movies WHERE id = :id')
  Future<MovieEntity?> findFavoriteById(int id);

  @insert
  Future<void> insertFavorite(MovieEntity movie);

  @delete
  Future<void> deleteFavorite(MovieEntity movie);
}
