import 'package:flutter/material.dart';
import 'package:flutterflix/models/person.dart';
import 'package:flutterflix/ui/widgets/actor_card.dart';

class CastingCard extends StatelessWidget {
  final List<Person>? personList;
  final double imageHeight; // Hauteur de la catégorie

  const CastingCard({
    super.key,
    required this.personList,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          SizedBox(
            height: imageHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: personList!.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return ActorCard(person: personList![index], imageWidth: 160);
              },
            ),
          ),
        ],
      ),
    );
    ;
  }
}
