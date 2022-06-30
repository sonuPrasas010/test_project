import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CMoviesTemplate extends StatelessWidget {
  final BoxFit fit;
  final String image, title, eqOrQuality;
  final Function onClick;
  const CMoviesTemplate(
      {required this.fit,
      required this.image,
      required this.title,
      required this.eqOrQuality,
      required this.onClick,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      
      child: GridTile(
        child: FadeInImage(
          fit: fit,
          image: NetworkImage(
            image,
          ),
          placeholder: const AssetImage(
            "lib/assets/images/loading.gif",
          ),
        ),
        footer: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
          ),
          child: Column(
            children: [
              AutoSizeText(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  // fontSize: 20.0,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              AutoSizeText(
                eqOrQuality,
                maxLines: 1,
                minFontSize: 8,
                maxFontSize: 11,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
