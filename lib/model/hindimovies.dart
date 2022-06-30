class HindiMovies {
  late String link;
  late String title;
  late String image;

  HindiMovies({
    required this.link,
    required this.title,
    required this.image,
  });

    


  HindiMovies fromJson(Map<String, dynamic> json) {
    link = json['link']??"";
    title = json['name']??"";
    image = json['image']??"";
    return this;
  }

  factory HindiMovies.fromJson(Map<String, dynamic> json) => HindiMovies(
        link: json['link'],
        title: json['name'] ?? "",
        image: json['image'] ?? "",
      );
}
