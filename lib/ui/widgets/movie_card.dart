import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterflix/models/movie.dart';
import 'package:flutterflix/repositories/data_repository.dart';
import 'package:flutterflix/ui/screens/movie_details_page.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:
          dataProvider.popularMoviesList.isEmpty
              ? const Center()
              : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(movie: movie),
                    ),
                  ); // Navigation vers la page de détails du film
                },
                child: CachedNetworkImage(
                  imageUrl:
                      movie
                          .posterURL(), // Utilisation de CachedNetworkImage pour le chargement d'images
                  fit:
                      BoxFit
                          .cover, // Ajuste l'image pour couvrir tout l'espace disponible
                  errorWidget:
                      (context, url, error) => const Icon(
                        Icons.error,
                      ), // Affiche une icône d'erreur si le chargement échoue

                  placeholder:
                      (context, url) => Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      ), // Affiche un indicateur de chargement pendant le chargement de l'image
                  // errorWidget: (context, url, error) => const Icon(Icons.error),// Affiche une icône d'erreur si le chargement échoue
                  // fit: BoxFit.cover,// Ajuste l'image pour couvrir tout l'espace disponible
                ),
              ),
    );
  }
}
