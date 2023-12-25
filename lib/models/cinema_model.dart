class Data {
    List<Datum> data;

    Data({
        required this.data,
    });

}

class Datum {
    String id;
    Room room;
    Movie movie;
    DateTime startTime;
    DateTime endTime;
    int price;
    int v;

    Datum({
        required this.id,
        required this.room,
        required this.movie,
        required this.startTime,
        required this.endTime,
        required this.price,
        required this.v,
    });

}

class Movie {
    String id;
    String title;
    String movieId;

    Movie({
        required this.id,
        required this.title,
        required this.movieId,
    });

}

class Room {
    String id;
    Cinema cinema;
    String name;

    Room({
        required this.id,
        required this.cinema,
        required this.name,
    });

}

class Cinema {
    Location location;
    String id;
    String name;
    int v;

    Cinema({
        required this.location,
        required this.id,
        required this.name,
        required this.v,
    });

}

class Location {
    List<double> coordinates;
    String address;
    String type;

    Location({
        required this.coordinates,
        required this.address,
        required this.type,
    });

}
