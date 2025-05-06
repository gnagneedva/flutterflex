// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutterflix/models/person.dart';
import 'package:flutterflix/services/api.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class ActorCard extends StatelessWidget {
  final Person person;
  final double
  imageWidth; // Largeur de la catégoriefinal double imageWidth; // Largeur de la catégorie
  const ActorCard({Key? key, required this.person, required this.imageWidth})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                person.imageURL != null
                    ? CachedNetworkImage(
                      imageUrl: API().baseImageUrl + person.imageURL!,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                      placeholder:
                          (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          ),
                    )
                    : Center(),
          ),
          const SizedBox(height: 4),
          Text(person.name, style: GoogleFonts.poppins(color: Colors.white)),
          Text(
            person.characterName,
            style: GoogleFonts.poppins(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
