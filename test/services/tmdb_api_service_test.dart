import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:primeiro_app/data/models/movie_model.dart';
import 'package:primeiro_app/data/services/tmdb_api_service.dart';


void main() {
  const apiKey = 'fake_api_key';

  group('TmdbApiService', () {
    late TmdbApiService api;

    test('fetchPopularMovies retorna lista de filmes ao responder 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode({
          'results': [
            {
              'id': 1,
              'title': 'Filme Popular',
              'overview': 'Descrição',
              'poster_path': '/poster.jpg',
              'release_date': '2025-01-01',
            },
          ]
        }), 200);
      });

      api = TmdbApiService(apiKey);
      http.get = mockClient.get;

      final movies = await api.fetchPopularMovies();
      expect(movies, isA<List<Movie>>());
      expect(movies.length, 1);
      expect(movies.first.title, 'Filme Popular');
    });

    test('fetchLatestMovies lança exceção se falhar', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Erro', 404);
      });

      api = TmdbApiService(apiKey);
      http.get = mockClient.get;

      expect(() async => await api.fetchLatestMovies(), throwsException);
    });

    test('searchMovies retorna filmes se sucesso', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode({
          'results': [
            {
              'id': 2,
              'title': 'Busca Teste',
              'overview': 'Filme de busca',
              'poster_path': '/busca.jpg',
              'release_date': '2025-02-02',
            },
          ]
        }), 200);
      });

      api = TmdbApiService(apiKey);
      http.get = mockClient.get;

      final movies = await api.searchMovies('teste');
      expect(movies.length, 1);
      expect(movies.first.title, 'Busca Teste');
    });
  });
}
