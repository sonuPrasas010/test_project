import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRatingBar extends StatelessWidget {
  final double rating;
 const MyRatingBar(this.rating, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 16,
      maxRating: 10,
      unratedColor: const Color(0xFF05478D),
      ignoreGestures: true,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: (Colors.red) /*Color(0xff4B97C5)*/,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
