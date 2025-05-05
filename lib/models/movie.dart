import 'package:flutterflix/models/person.dart';

import '../services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;
  final String? releaseDate;
  final double? vote;
  final List<String>? videos;
  final List<Person>? casting;

  Movie({
    required this.id,
    required this.name,
    required this.description,
    this.posterPath,
    this.genres,
    this.releaseDate,
    this.vote,
    this.videos,
    this.casting,
  });

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? posterPath,
    String? releaseDate,
    double? vote,
    List<String>? genres,
    List<String>? videos,
    List<Person>? casting,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      releaseDate: releaseDate ?? this.releaseDate,
      vote: vote ?? this.vote,
      videos: videos ?? this.videos,
      casting: casting ?? this.casting,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['title'],
      description: map['overview'],
      posterPath: map['poster_path'],
    );
  }
  String posterURL() {
    API api = API();
    return api.baseImageUrl +
        posterPath!; //"!" pour dire que posterPath ne dois pas etre null(une sorte de vérif)
  }

  String reformatGenres() {
    String categories = '';
    for (int i = 0; i < genres!.length; i++) {
      categories += genres![i];

      // Ajoute une virgule entre les genres sauf pour le dernier
      // On utilise "genres!.length - 1" pour éviter d'ajouter une virgule après le dernier genre
      if (i != genres!.length - 1) {
        categories += ', ';
      }
    }
    return categories;
  }
}
