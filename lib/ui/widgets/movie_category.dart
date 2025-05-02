import 'package:flutter/material.dart';
import 'package:flutterflix/models/movie.dart';
import 'package:flutterflix/ui/widgets/movie_card.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieCategory extends StatelessWidget {
  final String label;
  final List<Movie> movieList; // Liste des films à afficher dans cette catégorie
  final double imageHeight; // Hauteur de la catégorie
  final double imageWidth; // Largeur de la catégorie
  const MovieCategory({
    super.key,
     required this.label,
    required this.movieList,
    required this.imageHeight,
    required this.imageWidth,
     });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      SizedBox(height: 34,),
            Text(
             label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize:18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4,),
            SizedBox(
              height: imageHeight,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kCardColor,
                      ),
                      margin: EdgeInsets.only(right: 7),
                      width: imageWidth,
                      child:  MovieCard(movie: movieList[index + 7]),// Affiche les films populaires à partir du huitième film
                    );
                  }
              ),
            ),
            SizedBox(height: 34,),
    ],);
  }
}