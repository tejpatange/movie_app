# Movie App

A Flutter application that allows users to explore movies, search for their favorites, and view detailed information about each movie. The app fetches data from the TVMaze API and provides a user-friendly interface similar to popular streaming services.

## Features

- **Home Screen**: Displays a list of movies categorized as Trending, Top Rated, and Popular.
- **Search Screen**: Users can search for movies using a search bar.
- **Details Screen**: Shows detailed information about the selected movie, including title, image, genres, language, rating, premiere date, and summary.
- **Responsive Design**: Compatible with various screen sizes including laptops, tablets, and mobile devices.

## Screenshots

![Home Screen](screenshots/home_screen.png)
![Search Screen](screenshots/search_screen.png)
![Details Screen](screenshots/details_screen.png)

## Technologies Used

- Flutter
- Dart
- HTTP package for API calls
- Google Nav Bar for navigation
- Lottie for animations

## API

The application fetches movie data from the [TVMaze API](https://api.tvmaze.com).

### Endpoints Used

- **Search Movies**: `https://api.tvmaze.com/search/shows?q={search_term}`
- **Fetch All Movies**: `https://api.tvmaze.com/search/shows?q=all`

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- A compatible IDE (e.g., Android Studio, Visual Studio Code)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/username/movie_app.git
2. Navigate to the project directory
3. install the dependencies
   flutter pub get
4. Run the application
