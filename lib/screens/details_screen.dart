import 'package:flutter/material.dart';
import 'package:movie_app/fetch_data.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;  // Accept the movie object

  // Constructor to receive the movie object
  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Adjusting image and text sizes based on screen width
              double imageWidth = constraints.maxWidth > 800 ? 300 : 200;
              double imageHeight = constraints.maxWidth > 800 ? 450 : 300;
              double titleSize = constraints.maxWidth > 800 ? 28 : 24;
              double summarySize = constraints.maxWidth > 800 ? 18 : 16;
      
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Image
                  Center(
                    child: Image.network(
                      movie.imageUrl,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
      
                  // Movie Title
                  Text(
                    movie.name,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 10),
      
                  // Movie Genres (if available)
                  if (movie.genres != null && movie.genres.isNotEmpty)
                    Text(
                      'Genres: ${movie.genres.join(", ")}',
                      style: TextStyle(fontSize: summarySize, color: Colors.grey),
                    ),
                  SizedBox(height: 10),
      
                  // Movie Language (if available)
                  if (movie.language != null)
                    Text(
                      'Language: ${movie.language}',
                      style: TextStyle(fontSize: summarySize, color: Colors.grey),
                    ),
                  SizedBox(height: 10),
      
                  // Movie Rating (if available)
                  if (movie.rating != null)
                    Text(
                      'Rating: ${movie.rating}',
                      style: TextStyle(fontSize: summarySize, color: Colors.grey),
                    ),
                  SizedBox(height: 10),
      
                  // Movie Premiere Date (if available)
                  if (movie.premiered != null)
                    Text(
                      'Premiered on: ${movie.premiered}',
                      style: TextStyle(fontSize: summarySize, color: Colors.grey),
                    ),
                  SizedBox(height: 10),
      
                  // Movie Summary
                  Text(
                    'Summary:',
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    movie.summary,
                    style: TextStyle(fontSize: summarySize, color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
