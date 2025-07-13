import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'viewmodel/search_viewmodel.dart';
import 'package:provider/provider.dart';

import 'core/localization/app_localizations.dart';  // Ajuste o caminho conforme seu projeto
import 'core/localization/l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';

import 'data/services/tmdb_api_service.dart';
import 'data/repository/movie_repository.dart';
import 'viewmodel/movie_viewmodel.dart';

import 'view/login_page.dart';
import 'view/home_page.dart';
import 'view/search_page.dart';
import 'view/details_page.dart';
import 'db/movie_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiKey = 'f2290f5f295c33140c6daa2e322cce0b';
  final apiService = TmdbApiService(apiKey);

  final database = await $FloorMovieDatabase
      .databaseBuilder('movie_database.db')
      .build();

  final repository = MovieRepository(apiService, database);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieViewModel(repository)..loadMovies(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(repository),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('pt', ''),
      ],
      locale: const Locale('pt'), // pode usar Locale('en') para testar inglês
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/search': (context) => SearchPage(),
        '/details': (context) => DetailsPage(),
      },
    );
  }
}
