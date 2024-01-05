import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart' as Getx;
import 'package:intl/intl.dart';
import 'package:movie_booking_app/cinema/screens/cinema_screen.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/core/respository/review_respository.dart';
import 'package:movie_booking_app/home/review_bloc/review_bloc.dart';
import 'package:movie_booking_app/home/screens/movie_trailer_Screen.dart';
import 'package:movie_booking_app/home/widgets/custom_textfields_rating.dart';
import 'package:movie_booking_app/models/movie_model.dart';
import 'package:movie_booking_app/models/review_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<Review>? reviews;
  final TextEditingController ratingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    ratingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => ReviewBloc(ReviewRespository(widget.movie.id))
            ..add(LoadReviewEvent()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 360,
                      width: double.infinity,
                      child: Image.network(
                        widget.movie.imageCover,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 32,
                      child: InkWell(
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
                      child: InkWell(
                        onTap: () {
                          Getx.Get.to(
                              MovieTrailerScreen(
                                videoUrl: widget.movie.trailer,
                              ),
                              transition: Getx.Transition.fade,
                              duration: const Duration(milliseconds: 1000));
                        },
                        child: Image.asset(
                          Constants.trailerPath,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.movie.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Constants.colorTitle,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movie.category.length,
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
                          widget.movie.category[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movie.actors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xff2B2B38),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            widget.movie.actors[index].avatar,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 23),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: ExpandableText(
                    widget.movie.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 5,
                    linkColor: Constants.colorTitle,
                    linkStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                ),
                const SizedBox(height: 47),
                InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      Getx.Get.to(
                          CinemaScreen(
                            id: widget.movie.id,
                            title: widget.movie.title,
                          ),
                          transition: Getx.Transition.fade,
                          duration: const Duration(milliseconds: 1000));
                    },
                    child: Image.asset(Constants.bookingPath)),
                const SizedBox(height: 25),
                const Text(
                  "Rating this movie",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 25),
                BlocBuilder<ReviewBloc, ReviewState>(
                  builder: (context, state) {
                    if(state is ReviewLoadingState){
                      return const Center(child: CircularProgressIndicator());
                    }
                    double myRating = 0;
                    return RatingBar.builder(
                      initialRating: myRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (rating) {
                        if (ratingController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'You forgot to text your thinking this movie!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            context
                                .read<ReviewBloc>()
                                .add(UpdateLoadReviewEvent(
                                  reviews: ratingController.text.trim(),
                                  rating: rating.toDouble(),
                                  context: context,
                                ));
                            ratingController.clear(); //clear text
                            FocusScope.of(context).unfocus(); // close keyboard
                          });
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: CustomTextFieldRating(
                    controller: ratingController,
                    hintText: 'Text your thinking in this movie',
                    onSendPressed: (review, rating) {},
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Review',
                  style: TextStyle(
                      color: Color(0xffDA004E),
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                BlocBuilder<ReviewBloc, ReviewState>(
                  builder: (context, state) {
                    if (state is ReviewLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    if (state is ReviewErrorState) {
                      return Text(state.error);
                    }
                    if (state is ReviewLoadedState) {
                      // Hiển thị danh sách review ở đây
                      final List<Review> reviews = state.reviews;

                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: reviews.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            String reviewTime = reviews[index].createdAt;

                            // turn String into DateTime
                            DateTime dateTime = DateTime.parse(reviewTime);

                            // format time
                            String formattedDateTime =
                                DateFormat("HH:mm dd/MM/yyyy").format(dateTime);

                            return Flexible(
                              child: GridTile(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          child: Image.network(
                                            reviews[index].user.avatar,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              reviews[index].user.username,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                RatingBar.builder(
                                                  initialRating:
                                                      reviews[index].rating!,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 16,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  onRatingUpdate: (rating) {

                                                  },
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 50),
                                                  child: Text(
                                                    formattedDateTime,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: Text(
                                                reviews[index].review,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Text(
                        "no data",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
