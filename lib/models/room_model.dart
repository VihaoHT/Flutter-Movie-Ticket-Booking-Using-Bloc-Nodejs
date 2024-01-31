class Room {
  String id;
  Cinema cinema;
  String name;

  Room({
    required this.id,
    required this.cinema,
    required this.name,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['_id'],
      cinema: Cinema.fromJson(json['cinema']),
      name: json['name'],
    );
  }
}

class Cinema {
  String id;
  Location location;
  String name;

  Cinema({
    required this.id,
    required this.location,
    required this.name,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['_id'],
      location: Location.fromJson(json['location']),
      name: json['name'],
    );
  }
}

class Location {
  List<double> coordinates;
  String address;


  Location({
    required this.coordinates,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: List<double>.from(json['coordinates']),
      address: json['address'],
    );
  }
}
