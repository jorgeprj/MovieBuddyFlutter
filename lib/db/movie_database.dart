import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'movie_entity.dart';
import 'movie_dao.dart';

part 'movie_database.g.dart'; // código gerado

@Database(version: 1, entities: [MovieEntity])
abstract class MovieDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
