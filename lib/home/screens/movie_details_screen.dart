import 'package:flutter/material.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/home/screens/movie_trailer_Screen.dart';
import 'package:movie_booking_app/models/movie_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final imageURL =
        'http://149.28.159.68:3000/img/movies/${widget.movie.imageCover}';
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                // Widget 1 (Dưới cùng)
                Container(
                  color: Colors.blue,
                  height: 360,
                  width: double.infinity,
                  child: Image.network(
                    imageURL,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                // Widget 2 (Trên cùng)
                Positioned(
                  top: 10,
                  left: 32,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      Constants.backPath,
                    ),
                  ),
                ),
                Positioned(
                  top: 278,
                  left: 184,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MovieTrailerScreen(
                            videoUrl: widget.movie.trailer,
                          );
                        },
                      ));
                    },
                    child: Image.asset(
                      Constants.trailerPath,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
