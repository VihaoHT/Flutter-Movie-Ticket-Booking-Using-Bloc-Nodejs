import 'dart:convert';

class User {
  final String id;
  final String email;
  final String username;
  final String token;
  final String? phone_number; // avatar and phone_number can be update later
  final String? avatar;
  final String role;
  User({required this.id,required this.email, required this.username, required this.token, required this.role, this.phone_number, this.avatar,});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'token': token,
      'phone_number': phone_number,
      'avatar': avatar,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      token: map['token'] ?? '',
      role: map['role'] ?? '',
      phone_number: map['phone_number'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
