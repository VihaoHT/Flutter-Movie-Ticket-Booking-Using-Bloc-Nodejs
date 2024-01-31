class Actor{
  final String id;
  final String name;
  final String dob;
  final String country;
  final String avatar;

  Actor({required this.id, required this.name, required this.dob, required this.country, required this.avatar});
  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['_id'],
      name: json['name'],
      dob: json['dob'],
      country: json['country'],
      avatar: json['avatar'],
    );
  }
}