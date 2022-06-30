import 'package:flutter/material.dart';

class CMoviesListTemplate extends StatelessWidget {
  final String hexCode, title, content;
  const CMoviesListTemplate(this.hexCode, this.title, this.content, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "\u25A0",
                    style: TextStyle(
                      fontSize: 8,
                    ),
                  ),
                  TextSpan(
                    text: "  " + title,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
