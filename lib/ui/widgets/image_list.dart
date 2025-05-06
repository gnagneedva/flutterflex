import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterflix/services/api.dart';
import 'package:flutterflix/utils/constant.dart';

class ImageList extends StatelessWidget {
  final String posterPath;
  const ImageList({super.key, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      margin: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: API().baseImageUrl + posterPath,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder:
              (context, url) => Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
        ),
      ),
    );
  }
}
