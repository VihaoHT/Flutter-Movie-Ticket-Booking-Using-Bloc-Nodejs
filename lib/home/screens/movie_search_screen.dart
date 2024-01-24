import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_app/core/constants/ultis.dart';
import 'package:movie_booking_app/models/movie_model.dart';
import 'package:get/get.dart' as Getx;
import '../../core/constants/constants.dart';
import '../search_bloc/search_bloc.dart';
import '../widgets/custom_textfileld_search.dart';
import 'movie_details_screen.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController serachController = TextEditingController();
  String? genreSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchErrorState) {
                print("search movie error : ${state.error}");
                showToastFailed(context, "search movie error : ${state.error}");
              }
            },
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SearchLoadedState) {
                List<Movie> movieList = state.movies;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: InkWell(
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(LoadSearchEvent(
                                        title: serachController != null
                                            ? serachController.text
                                            : "",
                                        category: genreSelected ?? "",
                                      ));
                                },
                                child: Image.asset(Constants.searchPath))),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: CustomTextFieldSearch(
                              controller: serachController,
                              hintText: "",
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 30),
                            child: InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Widget _buildFilterOption(
                                          BuildContext context, String genre) {
                                        return SimpleDialogOption(
                                            child: OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    genreSelected = genre;
                                                    print(genreSelected);
                                                  });
                                                  Navigator.pop(context, genre);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(genre,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color: Constants
                                                              .colorTitle)),
                                                )));
                                      }

                                      return SimpleDialog(
                                        title: const Center(
                                            child: Text(
                                          'Choose a Genre',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        backgroundColor:
                                            const Color(0xff130B2B),
                                        children: <Widget>[
                                          _buildFilterOption(context, 'action'),
                                          _buildFilterOption(context, 'comedy'),
                                          _buildFilterOption(
                                              context, 'science-fiction'),
                                          _buildFilterOption(context, 'drama'),
                                          _buildFilterOption(
                                              context, 'fantasy'),
                                          _buildFilterOption(
                                              context, 'tragedy'),
                                          _buildFilterOption(
                                              context, 'romance'),
                                          Row(
                                            children: [
                                              // this is for reset button
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(onTap: () {
                                                  setState(() {
                                                    genreSelected = null;
                                                    Navigator.pop(context);
                                                  });
                                                },child: Image.asset(Constants.undoPath,width: 34,height: 34,)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: genreSelected != null
                                    ? Text(
                                        genreSelected!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Image.asset(Constants.filterPath))),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                            Getx.Get.to(()=>
                                MovieDetailsScreen(movie: movieList[index]),
                                transition: Getx.Transition.circularReveal,
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
                                      fit: BoxFit.fill,
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
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: InkWell(
                              onTap: () {
                                context.read<SearchBloc>().add(LoadSearchEvent(
                                      title: serachController != null
                                          ? serachController.text
                                          : null,
                                      category: genreSelected ?? "",
                                    ));
                              },
                              child: Image.asset(Constants.searchPath))),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: CustomTextFieldSearch(
                            controller: serachController,
                            hintText: "",
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: InkWell(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Widget _buildFilterOption(
                                        BuildContext context, String genre) {
                                      return SimpleDialogOption(
                                        onPressed: () {
                                          // Xử lý khi người dùng chọn một thể loại
                                          genreSelected = genre;
                                          print(genreSelected);

                                          Navigator.pop(context, genre);
                                        },
                                        child: Text(
                                          genre,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    }

                                    return SimpleDialog(
                                      title: const Text('Choose a Genre'),
                                      children: <Widget>[
                                        _buildFilterOption(context, 'action'),
                                        _buildFilterOption(context, 'comedy'),
                                        _buildFilterOption(
                                            context, 'science-fiction'),
                                        _buildFilterOption(context, 'drama'),
                                        _buildFilterOption(context, 'fantasy'),
                                        _buildFilterOption(context, 'tragedy'),
                                        _buildFilterOption(context, 'romance'),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: genreSelected != null
                                  ? Text(
                                      genreSelected!,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Image.asset(Constants.filterPath))),
                    ],
                  ),
                  const Text(
                    "NO DATA",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
