class CMovies {
  late String title;
  late String epOrQuality;
  late String image;
  late String link;

  CMovies(
    this.title,
    this.epOrQuality,
    this.image,
    this.link,
  );

  CMovies fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    epOrQuality = json['epOrQuality'] ?? "";
    image = json['image'] ?? "";
    link = json['link'] ?? "";

    return this;
  }

  factory CMovies.fromJson(Map<String, dynamic> json) {
    return CMovies(
      json['title'] ?? "",
      json['epOrQuality'] ?? "",
      json['image'] ?? "",
      json['link'] ?? "",
    );
  }
}
