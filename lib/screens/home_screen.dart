import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details_screen.dart';
import 'package:movie_app/fetch_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<List<Movie>>> _moviesByCategory;

  @override
  void initState() {
    super.initState();
    _moviesByCategory = fetchAllCategories();
  }

  // Function to fetch movies for all categories
  Future<List<List<Movie>>> fetchAllCategories() async {
    final trendingMovies = fetchMoviesByCategory('trending');
    final topRatedMovies = fetchMoviesByCategory('top-rated');
    final popularMovies = fetchMoviesByCategory('popular');

    // Wait for all three categories to load
    return Future.wait([trendingMovies, topRatedMovies, popularMovies]);
  }

  // Function to fetch movies from API for each category
  Future<List<Movie>> fetchMoviesByCategory(String category) async {
    final response =
        await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load $category movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<List<Movie>>>(
        future: _moviesByCategory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Movie> trendingMovies = snapshot.data![0];
            List<Movie> topRatedMovies = snapshot.data![1];
            List<Movie> popularMovies = snapshot.data![2];

            return ListView(
              children: [
                _buildCategoryRow(context, 'Trending Now', trendingMovies),
                _buildCategoryRow(context, 'Top Rated', topRatedMovies),
                _buildCategoryRow(context, 'Popular on TVMaze', popularMovies),
              ],
            );
          } else {
            return Center(child: Text('No Movies Found'));
          }
        },
      ),
    );
  }

  // Function to build horizontal scrolling category rows
  Widget _buildCategoryRow(
      BuildContext context, String categoryTitle, List<Movie> movies) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              categoryTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: movies.map((movie) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double width = constraints.maxWidth > 800 ? 160 : 120;
                        double height = constraints.maxWidth > 800 ? 240 : 180;

                        return Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(movie.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
