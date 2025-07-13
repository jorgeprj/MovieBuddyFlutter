import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/search_viewmodel.dart';
import '../data/models/movie_model.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchVM = Provider.of<SearchViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Filmes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Digite o nome do filme',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    searchVM.searchResults = [];
                    searchVM.error = null;
                    searchVM.notifyListeners();
                  },
                ),
              ),
              onChanged: (text) {
                // Busca automática conforme digita
                searchVM.search(text);
              },
            ),
            SizedBox(height: 16),
            if (searchVM.isLoading)
              CircularProgressIndicator(),
            if (searchVM.error != null)
              Text('Erro: ${searchVM.error}'),
            if (!searchVM.isLoading && searchVM.searchResults.isEmpty)
              Text('Nenhum resultado'),
            Expanded(
              child: ListView.builder(
                itemCount: searchVM.searchResults.length,
                itemBuilder: (context, index) {
                  final movie = searchVM.searchResults[index];
                  return ListTile(
                    leading: movie.posterPath.isNotEmpty
                        ? Image.network(
                      movie.fullPosterPath,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                        : SizedBox(width: 50),
                    title: Text(movie.title),
                    subtitle: Text(movie.releaseDate),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: movie,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
