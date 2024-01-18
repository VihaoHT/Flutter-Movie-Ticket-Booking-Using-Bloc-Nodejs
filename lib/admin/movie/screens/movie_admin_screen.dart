import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/core/constants/ultis.dart';

import '../../../core/components/header_admin.dart';
import '../../../home/movie_bloc/movie_bloc.dart';
import '../../../models/movie_model.dart';

class MovieAdminScreen extends StatelessWidget {
  const MovieAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderAdmin(title: "Movie Manager"),
              const SizedBox(height: 50),
              InkWell(
                splashColor: Colors.red,
                hoverColor: Colors.white54,
                onTap: () {},
                child: Container(
                  width: 195,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF212332),
                  ),
                  child: const ListTile(
                    title: Text(
                      "Add new Movie",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              BlocConsumer<MovieBloc, MovieState>(
                listener: (context, state) {
                  if (state is MovieErrorState) {
                    showToastFailed(context,
                        "Failed to load data ${state.error.toString()}");
                    Text(
                      state.error.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is MovieLoadedState) {
                    List<Movie> movieList = state.movies;
                    return Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: movieList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    movieList[index].imageCover,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Text(
                                            "title :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          movieList[index].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Text(
                                            "Ratings Average  :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          movieList[index]
                                              .ratingsAverage
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            splashColor: Colors.red,
                                            hoverColor: Colors.white54,
                                            onTap: () {},
                                            child: Container(
                                              width: 100,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blue,
                                              ),
                                              child: const ListTile(
                                                title: Text(
                                                  "Update",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        movieList[index].status == false
                                            ? InkWell(
                                                splashColor: Colors.red,
                                                hoverColor: Colors.white54,
                                                onTap: () {},
                                                child: Container(
                                                  width: 100,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green,
                                                  ),
                                                  child: const ListTile(
                                                      title: Text(
                                                    "Active",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              )
                                            : InkWell(
                                                splashColor: Colors.red,
                                                hoverColor: Colors.white54,
                                                onTap: () {},
                                                child: Container(
                                                  width: 110,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.red,
                                                  ),
                                                  child: const ListTile(
                                                      title: Text(
                                                    "Inactive",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              )
                                      ],
                                    ),
                                    InkWell(
                                      splashColor: Colors.red,
                                      hoverColor: Colors.white54,
                                      onTap: () {},
                                      child: Container(
                                        width: 100,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          color: Colors.deepPurple,
                                        ),
                                        child: const ListTile(
                                            title: Text(
                                              "More Details",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
