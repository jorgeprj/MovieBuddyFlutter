// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $MovieDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $MovieDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $MovieDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<MovieDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorMovieDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MovieDatabaseBuilderContract databaseBuilder(String name) =>
      _$MovieDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MovieDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$MovieDatabaseBuilder(null);
}

class _$MovieDatabaseBuilder implements $MovieDatabaseBuilderContract {
  _$MovieDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $MovieDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $MovieDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<MovieDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MovieDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MovieDatabase extends MovieDatabase {
  _$MovieDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorite_movies` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `overview` TEXT NOT NULL, `posterPath` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'favorite_movies',
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate
                }),
        _movieEntityDeletionAdapter = DeletionAdapter(
            database,
            'favorite_movies',
            ['id'],
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  final DeletionAdapter<MovieEntity> _movieEntityDeletionAdapter;

  @override
  Future<List<MovieEntity>> findAllFavorites() async {
    return _queryAdapter.queryList('SELECT * FROM favorite_movies',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String,
            releaseDate: row['releaseDate'] as String));
  }

  @override
  Future<MovieEntity?> findFavoriteById(int id) async {
    return _queryAdapter.query('SELECT * FROM favorite_movies WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            overview: row['overview'] as String,
            posterPath: row['posterPath'] as String,
            releaseDate: row['releaseDate'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertFavorite(MovieEntity movie) async {
    await _movieEntityInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFavorite(MovieEntity movie) async {
    await _movieEntityDeletionAdapter.delete(movie);
  }
}
