import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;
import 'package:http/http.dart';

import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/home/movie_bloc/movie_bloc.dart';
import 'package:movie_booking_app/home/screens/movie_details_screen.dart';
import 'package:movie_booking_app/home/widgets/custom_textfileld_search.dart';
import 'package:movie_booking_app/models/movie_model.dart';
import '../top5_bloc/top5_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController serachController = TextEditingController();

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MovieErrorState) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(fontSize: 12),
            ),
          );
        }
        if (state is MovieLoadedState) {
          List<Movie> movieList = state.movies;
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 25),
                        child: Row(
                          children: [
                            Image.asset(Constants.searchPath),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 21),
                                child: CustomTextFieldSearch(
                                  controller: serachController,
                                  hintText: "",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 13),
                      child: const Text(
                        "Top 5 Movies Highest rating:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<Top5Bloc, Top5State>(
                      builder: (context, state) {
                        if (state is Top5LoadedState) {
                          List<Movie> top5movieList = state.movies;
                          return CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 370,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ),
                            itemCount: top5movieList.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                InkWell(
                                  onTap: () {
                                    Getx.Get.to(
                                        MovieDetailsScreen(movie: top5movieList[itemIndex]),
                                        transition: Getx.Transition.circularReveal,
                                        duration: const Duration(milliseconds: 600));
                                  },
                                  child: Column(
                              children: [
                                  Stack(
                                    children: [
                                      Image.network(
                                        top5movieList[itemIndex].imageCover,
                                        height: 260,
                                        width: 300,
                                        fit: BoxFit.fill,
                                        color: const Color.fromRGBO(255, 255, 255, 0.5555), //this color is for opacity image
                                        colorBlendMode: BlendMode.modulate,
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Text(
                                          top5movieList[itemIndex].ratingsAverage.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        bottom: 13,
                                        left: 40,
                                        child: Icon(Icons.star,color: Colors.yellow,)
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    top5movieList[itemIndex].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Constants.colorTitle,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                              ],
                            ),
                                ),
                          );
                        }
                        return const SizedBox(
                          child: Text(
                            "NNO DATA FOUND",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 13),
                      child: const Text(
                        "List Movie is onboard:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 9),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 21.0,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: movieList.length,
                      itemBuilder: (context, index) {
                        // print(movieList[index].title);
                        return InkWell(
                          onTap: () {
                            Getx.Get.to(
                                MovieDetailsScreen(movie: movieList[index]),
                                transition: Getx.Transition.circularReveal,
                                duration: const Duration(milliseconds: 600));
                          },
                          child: GridTile(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14.0),
                                    child: Image.network(
                                      movieList[index].imageCover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  movieList[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Constants.colorTitle,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 25),
                    child: Row(
                      children: [
                        Image.asset(Constants.searchPath),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 21),
                            child: CustomTextFieldSearch(
                              controller: serachController,
                              hintText: "",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text("No data found"),
              ],
            ),
          ),
        );
      },
    );
  }
}
