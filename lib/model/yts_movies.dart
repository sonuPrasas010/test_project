class YTSMovies {
  late String title, genre, image, link, year;

  late double rating;

  YTSMovies({
    required this.title,
    required this.genre,
    required this.image,
    required this.link,
    required this.year,
    required this.rating,
  });

  factory YTSMovies.fromJson(Map<String, dynamic> json) {
    return YTSMovies(
      title: json['title'] ?? "",
      genre: json['genres'] ?? "",
      image: json['image'] ?? "",
      link: json['link'] ?? "",
      year: json['year'] ?? "",
      rating: json['rating'] != null
          ? double.parse(json['rating'].toString())
          : 0.0,
    );
  }

  YTSMovies fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    genre = json['genres'] ?? "";
    image = json['image'] ?? "";
    link = json['link'] ?? "";
    year = json['year'] ?? "";
    rating = json['rating'] != null
        ? double.parse(json['rating'].toString())
        : 0.0;
    return this;
  }
}
