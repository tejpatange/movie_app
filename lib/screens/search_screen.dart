import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details_screen.dart';
import 'package:movie_app/fetch_data.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String _query = '';

  // Function to fetch search results
  Future<void> fetchSearchResults(String query) async {
    if (query.isEmpty) return; // Prevent empty queries

    setState(() {
      _isLoading = true;
      _searchResults = []; // Clear previous results
    });

    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        setState(() {
          _searchResults = jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e); // Log error for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: _buildSearchBar(),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
          : _buildSearchResults(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for movies...',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.white),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _query = '';
                      _searchResults.clear(); // Clear results when search is cleared
                    });
                  },
                )
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        onSubmitted: (query) {
          setState(() {
            _query = query;
          });
          fetchSearchResults(query);
        },
      ),
    );
  }

  // Build the grid of search results
  Widget _buildSearchResults() {
    if (_query.isEmpty) {
      return Center(
        child: Text(
          'Search for movies',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust the number of columns based on screen width
        int columns = 3; // Default for smaller devices
        if (constraints.maxWidth > 1200) {
          columns = 6; // Large screens like laptops
        } else if (constraints.maxWidth > 800) {
          columns = 4; // Tablets
        }

        return GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, // Use the dynamic column count
            childAspectRatio: 0.7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final movie = _searchResults[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(movie: movie),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  movie.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
