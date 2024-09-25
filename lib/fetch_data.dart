import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Movie.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

class Movie {
  final String name;
  final String summary;
  final String imageUrl;
  final String? language;
  final String? rating;
  final List<String> genres;
  final String? premiered;

  Movie({
    required this.name,
    required this.summary,
    required this.imageUrl,
    this.language,
    this.rating,
    required this.genres,
    this.premiered,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['show']['name'] ?? 'No Title',
      summary: json['show']['summary'] ?? 'No summary available',
      imageUrl: json['show']['image'] != null
          ? json['show']['image']['medium']
          : 'https://via.placeholder.com/150',  // Placeholder image if no image found
      language: json['show']['language'],
      rating: json['show']['rating']['average']?.toString() ?? 'Not rated',
      genres: json['show']['genres'] != null ? List<String>.from(json['show']['genres']) : [],
      premiered: json['show']['premiered'],
    );
  }
}


Future<List<Movie>> searchMovies(String query) async {
  final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Movie.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load search results');
  }
}