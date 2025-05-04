import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterflix/models/movie.dart';
import 'package:flutterflix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService _apiService =
      APIService(); // Instance de l'APIService pour effectuer des appels API
  // List of movies
  List<Movie> _popularMoviesList = []; // Liste des films populaires
  // Index de la page pour la pagination des films populaires
  int _popularMoviesPageIndex = 1;

  List<Movie> _nowPlayingList = []; // Liste des films actuellement à l'affiche
  // Index de la page pour la pagination des films actuellement à l'affiche
  int _nowPlayingPageIndex = 1;

  // Getter pour les films populaires
  List<Movie> get popularMoviesList => _popularMoviesList;

  // Getter pour les films actuellement à l'affiche
  List<Movie> get nowPlayingList => _nowPlayingList;

  Future<void> getPopularMovies() async {
    try {
      // Appel de l'API pour récupérer les films populaires
      List<Movie> movies = await _apiService.getPopularMovies(
        pageNumber: _popularMoviesPageIndex, // Numéro de la page actuelle
      );
      _popularMoviesList.addAll(
        movies,
      ); // Ajoute les nouveaux films à la liste existante
      _popularMoviesPageIndex++; // Incrémente l'index de la page pour la prochaine requête
      notifyListeners(); // Notifie les écouteurs que les données ont changé
    } on Response catch (response) {
      print("Error fetching popular movies: ${response.statusCode}");
      rethrow; // Relance l'erreur pour la gestion des erreurs
    }
  }

  Future<void> getNowPlaying() async {
    try {
      // Appel de l'API pour récupérer les films populaires
      List<Movie> movies = await _apiService.getNowPlaying(
        pageNumber: _nowPlayingPageIndex, // Numéro de la page actuelle
      );
      _nowPlayingList.addAll(
        movies,
      ); // Ajoute les nouveaux films à la liste existante
      _nowPlayingPageIndex++; // Incrémente l'index de la page pour la prochaine requête
      notifyListeners(); // Notifie les écouteurs que les données ont changé
    } on Response catch (response) {
      print("Error fetching popular movies: ${response.statusCode}");
      rethrow; // Relance l'erreur pour la gestion des erreurs
    }
  }

  Future<void> initData() async {
    // Initialise les données en récupérant les films populaires
    await getPopularMovies();
    // Récupère les films actuellement à l'affiche
    await getNowPlaying();
  }
}
