import 'package:dio/dio.dart';
import 'package:flutterflix/models/person.dart';
import 'package:flutterflix/services/api.dart';
import '../models/movie.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    //construction de l'url
    String url = api.baseUrl + path;

    //construction des params
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',

      //params communs à toutes les requettes
    };

    if (params != null) {
      query.addAll(params);
    }
    final response = await dio.get(url, queryParameters: query);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData(
      'movie/popular',
      params: {'page': pageNumber},
    );
    if (response.statusCode == 200) {
      Map data = response.data;

      //liste de map Map<dynamic>net surtout pas de Map<String, dynamic>
      List<dynamic> results = data['results'];

      //liste de movies
      List<Movie> movies = [];

      //pour chaque éléments, on le converti en un objet de la classe movie.
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData(
      'movie/now_playing',
      params: {'page': pageNumber},
    );
    if (response.statusCode == 200) {
      Map data = response.data;

      // On récupère la liste des films à partir de la réponse JSON
      List<Movie> movies =
          data['results'].map<Movie>((dynamic movieJson) {
            // On utilise le constructeur fromJson de la classe Movie pour créer un objet Movie à partir du JSON
            // et on le retourne dans la liste.
            return Movie.fromJson(movieJson);
          }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcoming({required int pageNumber}) async {
    Response response = await getData(
      'movie/upcoming',
      params: {'page': pageNumber},
    );
    if (response.statusCode == 200) {
      Map data = response.data;

      // On récupère la liste des films à partir de la réponse JSON
      List<Movie> movies =
          data['results'].map<Movie>((dynamic movieJson) {
            // On utilise le constructeur fromJson de la classe Movie pour créer un objet Movie à partir du JSON
            // et on le retourne dans la liste.
            return Movie.fromJson(movieJson);
          }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationsMovies({required int pageNumber}) async {
    Response response = await getData(
      'discover/movie',
      params: {'page': pageNumber, 'with_genres': '16'},
    );
    if (response.statusCode == 200) {
      Map data = response.data;

      // On récupère la liste des films à partir de la réponse JSON
      List<Movie> movies =
          data['results'].map<Movie>((dynamic movieJson) {
            // On utilise le constructeur fromJson de la classe Movie pour créer un objet Movie à partir du JSON
            // et on le retourne dans la liste.
            return Movie.fromJson(movieJson);
          }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data; // On récupère la réponse JSON

      var genres = _data['genres'] as List; // On récupère la liste des genres

      // On utilise map pour transformer chaque genre en son nom
      // et toList pour convertir le résultat en une liste de chaînes de caractères
      List<String> genreList =
          genres.map((item) => item['name'] as String).toList();

      Movie newMovie = movie.copyWith(
        genres: genreList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average'].toDouble(),
      );
      return newMovie; // On retourne le nouvel objet Movie avec les détails mis à jour
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}/videos');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> videosKeys =
          (_data['results'] as List).map((videoJson) {
            return videoJson['key'] as String;
          }).toList();
      //         List<String> videoKeys =
      // _data['results'].map<String>((videoJson) {
      //   return videoJson['key'] as String;
      // }).toList();

      return movie.copyWith(videos: videosKeys, genres: movie.genres);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCasting({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<Person> casting =
          (_data['cast'] as List).map((personJson) {
            return Person.fromJson(personJson);
          }).toList();
      return movie.copyWith(casting: casting /*genres: movie.genres*/);
    } else {
      throw response;
    }
  }
}
//path: le chemin
//params: clé d'api, langue, page...


// 🟠 1ère façon (avec as List)

// List<String> videoKeys =
//   (_data['results'] as List).map((videoJson) {
//     return videoJson['key'] as String;
//   }).toList();

//     Tu dis à Dart que _data['results'] est une List.

//     Ensuite, tu transformes chaque élément en String (videoJson['key']).

//     Tu convertis le tout en List<String> avec toList().

// 🟢 C’est pratique si Dart ne sait pas quel est le type de results.
// 🔵 2ème façon (avec map<String>)

// List<String> videoKeys =
//   _data['results'].map<String>((videoJson) {
//     return videoJson['key'] as String;
//   }).toList();

//     Ici, tu ne dis pas que c’est une List, tu supposes que Dart le sait déjà.

//     Tu dis que map va produire des String (map<String>).

//     Plus rapide à lire, mais ça peut crasher si Dart n’est pas sûr du type.

// ✅ Conclusion :

// Si tu es sûr que _data['results'] est une vraie List, la 2e façon est plus propre.

// Sinon, la 1re est plus sûre dans les cas ambigus.