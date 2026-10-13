# Flutter Movie App
A movie app built with Flutter and the [TMDB API](https://www.themoviedb.org). Search for movies and see where to stream them.

## Screenshots
<p>
  <img src="./screenshots/start.png" width="160" hspace="4">
  <img src="./screenshots/search.png" width="160" hspace="4">
  <img src="./screenshots/detailpage_1.png" width="160" hspace="4">
  <img src="./screenshots/detailpage_2.png" width="160" hspace="4">
</p>

## Features
**Start & search**
- Trending movies of the week as poster grid
- Search movies by title
- Results load automatically while scrolling
- Poster, release year and user rating for every result

**Movie details**
- Backdrop card with title, rating and year
- Upcoming German release date for unreleased movies (cinema or streaming)
- Runtime, age rating (FSK) and genres
- Plot summary
- Streaming services (subscription only)
- Director and cast
- Blurred backdrop as page background

## Getting started
1. Get a free API key at [themoviedb.org](https://www.themoviedb.org/settings/api).
2. Create the file `lib/api/api_key.dart`:

   ```dart
   class ApiKey {
     static const String apiKey = 'YOUR_API_KEY';
   }
   ```
3. Run the app:

   ```
   flutter pub get
   flutter run
   ```

## API Documentation
https://developer.themoviedb.org/docs

## Credits
Data provided by [The Movie Database](https://www.themoviedb.org).  
Watch providers provided by [JustWatch](https://www.justwatch.com/).

<img height="15px" src="./tmdb_logo.svg">

This product uses the TMDB API but is not endorsed or certified by TMDB.
