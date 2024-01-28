class Cinema {
  final String id;
  final String name;
  final Location location;

  Cinema({required this.id, required this.name, required this.location});

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['_id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final List<double> coordinates;
  final String address;
  final String type;

  Location({required this.coordinates, required this.address, required this.type});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: List<double>.from(json['coordinates']),
      address: json['address'],
      type: json['type'],
    );
  }
}
