import 'dart:convert';

class User {
  final String email;
  final String username;
  final String token;
  final String? phone_number;
  final String? avatar;
  User({required this.email, required this.username, required this.token, this.phone_number, this.avatar,});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'token': token,
      'phone_number': phone_number,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      token: map['token'] ?? '',
      phone_number: map['phone_number'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
