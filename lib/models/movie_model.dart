class Movie {
  final String id;
  final String title;
  final List<String> category;
  final double ratingsAverage;
  final int ratingsQuantity;
  final List<Actor> actors;
  final int duration;
  final DateTime releaseDate;
  final String imageCover;
  final String description;
  final String trailer;
  final bool status;

  Movie({
    required this.id,
    required this.title,
    required this.category,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.actors,
    required this.duration,
    required this.releaseDate,
    required this.imageCover,
    required this.description,
    required this.trailer,
    required this.status,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      title: json['title'],
      category: List<String>.from(json['category']),
      ratingsAverage: json['ratingsAverage'].toDouble(),
      ratingsQuantity: json['ratingsQuantity'],
      actors: List<Actor>.from(json['actor'].map((actor) => Actor.fromJson(actor))),
      duration: json['duration'],
      releaseDate: DateTime.parse(json['release_date']),
      imageCover: json['imageCover'],
      description: json['description'],
      trailer: json['trailer'],
      status: json['status'],
    );
  }
}

class Actor {
  final String id;
  final String name;
  final DateTime dob;
  final String country;
  final String avatar;

  Actor({
    required this.id,
    required this.name,
    required this.dob,
    required this.country,
    required this.avatar,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['_id'],
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      country: json['country'],
      avatar: json['avatar'],
    );
  }
}
