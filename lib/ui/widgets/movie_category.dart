import 'package:flutter/material.dart';
import 'package:flutterflix/models/movie.dart';
import 'package:flutterflix/ui/widgets/movie_card.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie>
  movieList; // Liste des films à afficher dans cette catégorie
  final double imageHeight; // Hauteur de la catégorie
  final double imageWidth; // Largeur de la catégorie
  final Function callback;
  const MovieCategory({
    super.key,
    required this.label,
    required this.movieList,
    required this.imageHeight,
    required this.imageWidth,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 34),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // Écoute les notifications de défilement
              final currentPosition =
                  notification
                      .metrics
                      .pixels; // Position actuelle du défilement
              final maxPosition =
                  notification
                      .metrics
                      .maxScrollExtent; // Position maximale de défilement
              if (notification.metrics.axis == Axis.horizontal) {
                // Si l'utilisateur fait défiler horizontalement
                print("currentPosition: $currentPosition");
                if (currentPosition >= maxPosition / 2) {// Si l'utilisateur a atteint le milieu de la liste, charger plus de films
                  // Si l'utilisateur a atteint le début de la liste, charger plus de films
                  callback(
                  // Ici, vous pouvez appeler une fonction pour charger plus de films
                    
                  );
                }
              }
              // if (notification.metrics.pixels ==
              //     notification.metrics.maxScrollExtent) {
              //   // Si l'utilisateur a atteint le bas de la liste, charger plus de films
              //   return true;
              // }
              return true; // Retourne true pour indiquer que la notification a été traitée
            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              physics: const BouncingScrollPhysics(), // Permet un défilement fluide
              itemBuilder: (BuildContext context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kCardColor,
                  ),
                  margin: EdgeInsets.only(right: 7),
                  width: imageWidth,
                  child: MovieCard(
                    movie: movieList[index],
                  ), // Affiche les films populaires à partir du huitième film
                );
              },
            ),
          ),
        ),
        SizedBox(height: 34),
      ],
    );
  }
}
