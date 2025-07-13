import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class TmdbApiService {
  final String apiKey;
  final String baseUrl = 'https://api.themoviedb.org/3';

  TmdbApiService(this.apiKey);

  Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=pt-BR&page=1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List results = jsonBody['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar filmes populares');
    }
  }

  Future<List<Movie>> fetchLatestMovies() async {
    final url = Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey&language=pt-BR&page=1');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List results = jsonBody['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar lançamentos');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse(
        '$baseUrl/search/movie?api_key=$apiKey&language=pt-BR&query=${Uri.encodeComponent(query)}&page=1&include_adult=false'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final List results = jsonBody['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar filmes');
    }
  }

}
