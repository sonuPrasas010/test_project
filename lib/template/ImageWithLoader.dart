import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWithLoader extends StatelessWidget {
  final String image;
  const ImageWithLoader(this.image, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.network(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          //  height: 500,
          height: 450 /*MediaQuery.of(context).size.height * 0.5*/,
          loadingBuilder:  (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.cumulativeBytesLoaded/
                      loadingProgress.expectedTotalBytes!.toDouble(),
                ),
              ),
            );
          }),
    );
  }
}
