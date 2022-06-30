import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
 
import '../model/yts_movies.dart';
import 'muRatingBar.dart';
import 'yts_movie_image_stack.dart';
import '../detailsPage/ytsMovieDetails.dart';

class YTSMoviesTemplate extends StatelessWidget {
  final YTSMovies _ytsMovies;
  // final Function
  const YTSMoviesTemplate(this._ytsMovies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Yts Movie Template ${_ytsMovies.title}");
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => YTSDetailsPage(_ytsMovies.link),
        //   ),
        // );
        Get.to(
          () => YTSDetailsPage(_ytsMovies.link),
          transition: Transition.zoom,
          preventDuplicates: false,
        );
      
      },
      child: Column(
        children: <Widget>[
          MyStack(_ytsMovies.image, _ytsMovies.year),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 4),
            child: Text(
              _ytsMovies.title,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight, fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AutoSizeText(
            _ytsMovies.genre,
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
            maxFontSize: 13,
            minFontSize: 10,
            maxLines: 1,
          ),
          // MyRatingBar(_ytsMovies.rating),
        ],
      ),
    );
  }
}
