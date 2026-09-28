import 'package:flutter/material.dart';

import '../data/movies_data.dart';
import '../models/movie.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void _openDetails(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final favorites = sampleMovies.where((m) => m.isFavorite).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final movie = favorites[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        movie.posterPath,
                        width: 48,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 48,
                            height: 64,
                            alignment: Alignment.center,
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer,
                            child: Text(movie.title.isNotEmpty
                                ? movie.title[0]
                                : '?'),
                          );
                        },
                      ),
                    ),
                    title: Text(movie.title),
                    subtitle: Text(movie.cast.first),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () =>
                          setState(() => movie.isFavorite = false),
                    ),
                    onTap: () => _openDetails(movie),
                  ),
                );
              },
            ),
    );
  }
}
