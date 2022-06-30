import 'package:flutter/material.dart';

class SearchTemplate extends StatelessWidget {
  final String imageUrl, title, url, year;
  final Function pag;
  SearchTemplate(
      {required this.imageUrl,
      required this.title,
      required this.url,
      required this.year,
      required this.pag});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> pag(),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: FadeInImage(
              height: 220,
              width: double.infinity,
              placeholder: const AssetImage("lib/assets/images/loading.gif"),
              image: NetworkImage(
                imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(top: 8.0),
          //   child: Text(
          //     'Batman',
          //     style: TextStyle(
          //       fontSize: 12,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.grey,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
