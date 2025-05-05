import 'package:flutter/material.dart';
import 'package:flutterflix/models/movie.dart';
import 'package:flutterflix/repositories/data_repository.dart';
import 'package:flutterflix/ui/widgets/button.dart';
import 'package:flutterflix/ui/widgets/movie_infos.dart';
import 'package:flutterflix/ui/widgets/video_player.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // Récupération des détails du film à partir de la liste des films populaires

    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    // Appel de la méthode getMovieDetails pour récupérer les détails du film

    setState(() {
      newMovie = _movie; // Mise à jour de l'état avec les détails du film
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor,
      appBar: AppBar(
        backgroundColor: kBackColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
      ),
      body:
          newMovie == null
              ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
              : Padding(
                padding: EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: NetworkImage(newMovie!.backdropURL()),
                        //   fit: BoxFit.cover,
                        // ),
                        color: kCardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          newMovie!.videos!.isEmpty
                              ? const Center(
                                child: Text(
                                  'Aucune vidéo disponible',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                              : VideoPlayer(movieId: newMovie!.videos!.first),
                    ),

                    MovieInfos(movie: newMovie!),
                    const SizedBox(height: 20),
                    Button(
                      text: 'Télécharger',
                      onPressed: () {},
                      color: kCardColor,
                      textColor: Colors.white,
                      icon: Icons.download,
                    ),
                    // const SizedBox(height: 10),
                    // Text(
                    //   newMovie!.overview,
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.white70,
                    //   ),
                    // ),
                  ],
                ),
              ),
    );
  }
}
