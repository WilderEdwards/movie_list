import 'package:flutter/material.dart';

import '../data/movies_data.dart';
import '../models/movie.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openDetails(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
    ).then((_) => setState(() {}));
  }

  void _openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FavoritesScreen()),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCount = sampleMovies.where((m) => m.isFavorite).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Watchlist'),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: _openFavorites,
              ),
              if (favoriteCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$favoriteCount',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(
            title: 'Trending Now',
            subtitle: 'Tap a movie to see details',
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: sampleMovies.length,
              itemBuilder: (context, index) {
                final movie = sampleMovies[index];
                return MovieListItem(
                  movie: movie,
                  onTap: () => _openDetails(movie),
                  onFavorite: () =>
                      setState(() => movie.isFavorite = !movie.isFavorite),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const HomeHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const MovieListItem({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: PosterPlaceholder(
          title: movie.title,
          posterPath: movie.posterPath,
        ),
        title: Text(movie.title),
        subtitle: Text(movie.cast.first),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: movie.isFavorite ? Colors.red : null,
              ),
              onPressed: onFavorite,
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class PosterPlaceholder extends StatelessWidget {
  final String title;
  final String posterPath;

  const PosterPlaceholder({
    super.key,
    required this.title,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        posterPath,
        width: 48,
        height: 64,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          final initial = title.isNotEmpty ? title[0] : '?';
          return Container(
            width: 48,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              initial,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        },
      ),
    );
  }
}
