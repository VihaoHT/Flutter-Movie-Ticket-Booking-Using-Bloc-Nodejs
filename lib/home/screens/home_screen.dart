import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;

import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/home/movie_bloc/movie_bloc.dart';
import 'package:movie_booking_app/home/screens/movie_details_screen.dart';
import 'package:movie_booking_app/home/widgets/custom_textfileld_search.dart';
import 'package:movie_booking_app/models/movie_model.dart';

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
              body: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    width:
                        MediaQuery.of(context).size.width, // Sửa đổi dòng này
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
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 13),
                    child: const Text(
                      "Danh sách phim đang công chiếu:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Expanded(
                    child: GridView.builder(
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
                            Getx.Get.to(MovieDetailsScreen(movie: movieList[index]),
                                transition: Getx.Transition.fade,
                                duration: const Duration(milliseconds: 1000));
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
                  ),
                ],
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
