import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/movie_model.dart';
import '../viewmodel/movie_viewmodel.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Movie movie;
  bool isFavorite = false;
  bool isLoadingFavorite = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    movie = ModalRoute.of(context)!.settings.arguments as Movie;

    final repo = Provider.of<MovieViewModel>(context, listen: false).repository;

    // Verifica se é favorito e atualiza o estado
    repo.isFavorite(movie.id).then((fav) {
      setState(() {
        isFavorite = fav;
        isLoadingFavorite = false;
      });
    });
  }

  void toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite; // muda o ícone na hora
    });

    final repo = Provider.of<MovieViewModel>(context, listen: false).repository;

    try {
      if (isFavorite) {
        await repo.addFavorite(movie);
      } else {
        await repo.removeFavorite(movie);
      }
    } catch (e) {
      // Se der erro, reverte o estado e mostra alerta
      setState(() {
        isFavorite = !isFavorite;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar favoritos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          isLoadingFavorite
              ? Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
          )
              : IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white, // branco tanto no preenchido quanto no contorno
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: movie.posterPath.isNotEmpty
                  ? Image.network(
                movie.fullPosterPath,
                width: 300,
                height: 450,
                fit: BoxFit.cover,
              )
                  : SizedBox(
                width: 300,
                height: 450,
                child: Center(child: Text('Sem imagem')),
              ),
            ),
            SizedBox(height: 16),
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
              'Data de lançamento: ${movie.releaseDate}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              movie.overview.isNotEmpty ? movie.overview : 'Sem descrição disponível.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}