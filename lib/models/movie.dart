// Movie model for the watchlist app.
// Holds everything DetailsScreen will need so we can pass
// a single object through Navigator instead of loose strings.
class Movie {
  final String title;
  final String posterPath;
  final List<String> cast;
  final String synopsis;

  const Movie({
    required this.title,
    required this.posterPath,
    required this.cast,
    required this.synopsis,
  });
}
