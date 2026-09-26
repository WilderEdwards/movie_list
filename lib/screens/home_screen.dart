import 'package:flutter/material.dart';

// Temporary in-file data so the HomeScreen runs on its own.
// Next step will extract this into models/movie.dart + data/movies_data.dart.
const List<String> _movieTitles = [
  'Inception',
  'The Matrix',
  'Interstellar',
  'Dune',
  'Spider-Man: No Way Home',
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onMovieTap(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title — details coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Watchlist'),
        centerTitle: true,
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
              itemCount: _movieTitles.length,
              itemBuilder: (context, index) {
                final title = _movieTitles[index];
                return MovieListItem(
                  title: title,
                  onTap: () => _onMovieTap(context, title),
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
  final String title;
  final VoidCallback onTap;

  const MovieListItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: PosterPlaceholder(title: title),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class PosterPlaceholder extends StatelessWidget {
  final String title;

  const PosterPlaceholder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Stands in for Image.asset() until assets/ are added.
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
  }
}
