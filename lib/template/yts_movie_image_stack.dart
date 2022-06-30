import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyStack extends StatelessWidget {
  final String image;
  final String year;
  const MyStack(this.image, this.year, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage(
            placeholder: const AssetImage("lib/assets/images/loading.gif"),
            imageErrorBuilder: (_, object, trace) {
              return Image.asset("lib/assets/images/the-sinner-2017.png");
            },
            image: NetworkImage(
              image,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
          ),
        ),
        Positioned(
          top: 6,
          right: 3,
          child: Transform.rotate(
            angle: 0.5,
            child: Text(
              year,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                backgroundColor: Color(0x7F000000),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
