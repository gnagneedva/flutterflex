import 'package:flutter/material.dart';
import 'package:flutterflix/models/movie.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieInfos extends StatelessWidget {
  final Movie movie;
  const MovieInfos({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textAlign: TextAlign.start,
              movie.name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                movie.releaseDate!.substring(0, 4),
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'genre: ${movie.reformatGenres()}',
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
            Text('73 Mins', style: GoogleFonts.poppins(color: Colors.white70)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const SizedBox(width: 10),
            Text(
              movie.vote!.toStringAsFixed(1),
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          movie.description,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
      ],
    );
  }
}
