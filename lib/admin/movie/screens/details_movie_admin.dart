import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/models/movie_model.dart';
import 'package:get/get.dart' as Getx;
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/constants.dart';
import '../../../home/movie_bloc/movie_bloc.dart';
import '../../../home/screens/movie_trailer_Screen.dart';

class DetailsMovieAdmin extends StatelessWidget {
  final Movie movie;

  const DetailsMovieAdmin({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    void openTrailer() async {
      final url = Uri.parse(movie.trailer);

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        print('Cannot launch Google Maps');
      }
    }

    String releaseTime = movie.releaseDate.toString();
    // turn String into DateTime
    DateTime dateTime = DateTime.parse(releaseTime);
    // format time
    String formattedDateTime = DateFormat("yyyy/MM/dd HH:mm").format(dateTime);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white54,
          backgroundColor: Constants.bgColorAdmin,
          title: Text("Detail Movie Of ${movie.title}"),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 50),
              child: InkWell(
                  onTap: () {
                    Getx.Get.defaultDialog(
                      title: "DELETE THE MOVIE!",
                      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                      middleText:
                          "Are you sure you want to delete this movie? After delete you cannot undo",
                      onCancel: () {
                        // do nothing
                      },
                      onConfirm: () {
                        Navigator.pop(context);
                        context.read<MovieBloc>().add(DeleteMovieEvent(
                            movieId: movie.id, context: context));
                      },
                      middleTextStyle: const TextStyle(
                          color: Constants.colorTitle,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.white54,
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    movie.imageCover,
                    width: 400,
                    height: 400,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    openTrailer();
                  },
                  child: Image.asset(
                    Constants.trailerPath,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Title: ',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: movie.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Release Date: ',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: formattedDateTime,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Duration: ',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: '${movie.duration} hours',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Rating Average: ',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: movie.ratingsAverage.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Rating Quantity: ',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: movie.ratingsQuantity.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Categories: ",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.category.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 40,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xff2B2B38),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        movie.category[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Actors: ",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.actors.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              movie.actors[index].avatar,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            movie.actors[index].name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Description: ",
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ExpandableText(
                movie.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
                linkColor: Colors.red,
                linkStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
