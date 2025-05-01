import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterflix/models/movie.dart';
import 'package:flutterflix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService _apiService = APIService();// Instance de l'APIService pour effectuer des appels API
  // List of movies
  List<Movie> _popularMoviesList = [];

  int _popularMoviesPageIndex = 1;

  // Getter pour les films populaires
  List<Movie> get popularMoviesList => _popularMoviesList;

  Future<void> getPopularMovies() async {
    try {
      // Appel de l'API pour récupérer les films populaires
      List<Movie> movies = await _apiService.getPopularMovies(
        pageNumber: _popularMoviesPageIndex,// Numéro de la page actuelle
      );
      _popularMoviesList.addAll(movies);// Ajoute les nouveaux films à la liste existante
      _popularMoviesPageIndex++; // Incrémente l'index de la page pour la prochaine requête
      notifyListeners(); // Notifie les écouteurs que les données ont changé
    } on Response catch (response) {
      print("Error fetching popular movies: ${response.statusCode}");
      rethrow;// Relance l'erreur pour la gestion des erreurs
    }
  }

  // Méthode pour charger la page suivante de films populaires
  Future<void> loadMorePopularMovies() async {
    _popularMoviesPageIndex++;
    await getPopularMovies();
  }
}
