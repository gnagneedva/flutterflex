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

  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData(
      'movie/${movie.id}',
      params: {
        'language': 'fr-FR',
        'include_image_language': 'null',
        'append_to_response': 'videos,credits,images',
      },
    );
    if (response.statusCode == 200) {
      Map _data = response.data;

      // On utilise map pour transformer chaque genre en son nom
      // et toList pour convertir le résultat en une liste de chaînes de caractères
      var genres = _data['genres'] as List; // On récupère la liste des genres
      List<String> genreList =
          genres.map((item) => item['name'] as String).toList();

      // On récupère la liste des vidéos à partir de la réponse JSON
      List<String> videosKeys =
          (_data['videos']['results'] as List).map((videoJson) {
            return videoJson['key'] as String;
          }).toList();

      // On récupère la liste des images à partir de la réponse JSON
      List<String> imagePath =
          (_data['images']['backdrops'] as List).map((imageJson) {
            return imageJson['file_path'] as String;
          }).toList();

      // On récupère la liste des acteurs à partir de la réponse JSON
      List<Person> casting =
          (_data['credits']['cast'] as List).map((personJson) {
            return Person.fromJson(personJson);
          }).toList();
      return movie.copyWith(
        genres: genreList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average'].toDouble(),
        videos: videosKeys,
        casting: casting,
        images: imagePath,
      );
    } else {
      throw response;
    }
  }

  // Future<List<Movie>> getMovieRecommendations({required Movie movie}) async {
  //   Response response = await getData(
  //     'movie/${movie.id}/recommendations',
  //     params: {'language': 'fr-FR'},
  //   );
  //   if (response.statusCode == 200) {
  //     Map data = response.data;
  //     List<Movie> movies =
  //         data['results'].map<Movie>((dynamic movieJson) {
  //           return Movie.fromJson(movieJson);
  //         }).toList();
  //     return movies;
  //   } else {
  //     throw response;
  //   }
  // }
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