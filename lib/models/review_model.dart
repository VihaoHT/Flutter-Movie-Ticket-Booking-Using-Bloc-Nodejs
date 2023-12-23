class Review {
  final String id;
  final String review;
  final double rating;
  final String createdAt;
  final String movieId;
  final User user;

  Review({
    required this.id,
    required this.review,
    required this.rating,
    required this.createdAt,
    required this.movieId,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? '',
      review: json['review'] ?? '',
      rating: json['rating'].toDouble(),
      createdAt: json['created_At'] ?? '',
      movieId: json['movie'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

class User {
  final String id;
  final String username;
  final String avatar;

  User({
    required this.id,
    required this.username,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
