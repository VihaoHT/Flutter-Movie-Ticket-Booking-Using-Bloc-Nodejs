class ShowTime {
  final String id;
  final Room room;
  final Movie movie;
  final DateTime startTime;
  final DateTime endTime;
  final int price;

  ShowTime({
    required this.id,
    required this.room,
    required this.movie,
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  factory ShowTime.fromJson(Map<String, dynamic> json) {
    return ShowTime(
      id: json['_id'] ?? '',
      room: Room.fromJson(json['room'] ?? {}),
      movie: Movie.fromJson(json['movie'] ?? {}),
      startTime: DateTime.parse(json['start_time'] ?? ''),
      endTime: DateTime.parse(json['end_time'] ?? ''),
      price: json['price'] ?? 0,
    );
  }
}

class Room {
  final String id;
  final Cinema cinema;
  final String name;

  Room({required this.id, required this.cinema, required this.name});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['_id'] ?? '',
      cinema: Cinema.fromJson(json['cinema'] ?? {}),
      name: json['name'] ?? '',
    );
  }
}

class Cinema {
  final Location location;
  final String id;
  final String name;
 

  Cinema({
    required this.location,
    required this.id,
    required this.name,
   
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      location: Location.fromJson(json['location'] ?? {}),
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Location {
  final List<double> coordinates;
  final String address;


  Location({
    required this.coordinates,
    required this.address,
  
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: List<double>.from(json['coordinates'] ?? []),
      address: json['address'] ?? '',
     
    );
  }
}

class Movie {
  final String id;
  final String title;

  Movie({required this.id, required this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
