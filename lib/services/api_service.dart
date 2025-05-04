import 'package:dio/dio.dart';
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
      'language': 'fr_FR',

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
}
//path: le chemin
//params: clé d'api, langue, page...