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

  List<Movie> _upcomingList = []; // Liste des films à venir
  // Index de la page pour la pagination des films à venir
  int _upcomingPageIndex = 1;

  // Getter pour la liste des animations
  // List<Movie> get animationList => _popularMoviesList
  //     .where((movie) => movie.genreIds.contains(16))
  //     .toList(); // Filtre les films pour ne garder que ceux de genre animation

  List<Movie> _animationsMoviesList = []; // Liste des films d'animation
  // Index de la page pour la pagination des films d'animation
  int _animationsMoviesPageIndex = 1;

  // Getter pour la liste des films d'animation
  List<Movie> get animationList => _animationsMoviesList;

  // Getter pour les films populaires
  List<Movie> get popularMoviesList => _popularMoviesList;

  // Getter pour les films actuellement à l'affiche
  List<Movie> get nowPlayingList => _nowPlayingList;

  // Getter pour les films à venir
  List<Movie> get upcomingList => _upcomingList;

  Future<void> getAnimationsMovies() async {
    try {
      // Appel de l'API pour récupérer les films d'animation
      List<Movie> movies = await _apiService.getAnimationsMovies(
        pageNumber: _animationsMoviesPageIndex, // Numéro de la page actuelle
      );
      _animationsMoviesList.addAll(
        movies,
      ); // Ajoute les nouveaux films à la liste existante
      _animationsMoviesPageIndex++; // Incrémente l'index de la page pour la prochaine requête
      notifyListeners(); // Notifie les écouteurs que les données ont changé
    } on Response catch (response) {
      print("Error fetching animation movies: ${response.statusCode}");
      rethrow; // Relance l'erreur pour la gestion des erreurs
    }
  }

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

  Future<void> getUpcoming() async {
    try {
      // Appel de l'API pour récupérer les films à venir
      List<Movie> movies = await _apiService.getUpcoming(
        pageNumber: _upcomingPageIndex, // Numéro de la page actuelle
      );
      _upcomingList.addAll(
        movies,
      ); // Ajoute les nouveaux films à la liste existante
      _upcomingPageIndex++; // Incrémente l'index de la page pour la prochaine requête
      notifyListeners(); // Notifie les écouteurs que les données ont changé
    } on Response catch (response) {
      print("Error fetching upcoming movies: ${response.statusCode}");
      rethrow; // Relance l'erreur pour la gestion des erreurs
    }
  }

  Future<void> initData() async {
    // Méthode d'initialisation pour charger les données au démarrage
    // Appel de toutes les méthodes pour récupérer les films

    await Future.wait([
      getPopularMovies(),
      getNowPlaying(),
      getUpcoming(),
      getAnimationsMovies(),
    ]);
  }
}
