import 'dart:convert';

class User {
  final String email;
  final String username;
  final String token;

  User({required this.email, required this.username, required this.token});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
