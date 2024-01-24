import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;
import 'package:movie_booking_app/admin/movie/widgets/custom_text_field_add.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/ultis.dart';
import '../../../home/movie_bloc/movie_bloc.dart';
import '../../../models/movie_model.dart';
import '../../../profile/widgets/custom_text_field_update.dart';

class UpdateMovieAdmin extends StatelessWidget {
  final Movie movie;

  const UpdateMovieAdmin({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController releaseDateController = TextEditingController();
    TextEditingController durationController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController actorController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white54,
        backgroundColor: Constants.bgColorAdmin,
        title: Text("Update the movie ${movie.title}"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 50),
            child: InkWell(
                onTap: () {
                  Getx.Get.defaultDialog(
                    title: "INFORMATION!",
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                    middleText:
                        "Category and actor cant be null",
                    middleTextStyle: const TextStyle(
                        color: Constants.colorTitle,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  );
                },
                child: Image.asset(
                  Constants.informationPath,
                  color: Colors.white54,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              movie.title != null
                  ? CustomTextFieldUpdate(
                      controller: titleController,
                      hintText: "this is Title",
                      label: movie.title,
                      readOnly: false,
                    )
                  : CustomTextFieldUpdate(
                      controller: titleController,
                      hintText: "",
                      label: "",
                      readOnly: false,
                    ),
              const SizedBox(height: 20),
              movie.duration != null
                  ? CustomTextFieldUpdate(
                      controller: durationController,
                      hintText: "this is duration",
                      label: movie.duration.toString(),
                      readOnly: false,
                    )
                  : CustomTextFieldUpdate(
                      controller: durationController,
                      hintText: "",
                      label: "",
                      readOnly: false,
                    ),
              const SizedBox(height: 20),
              movie.releaseDate != null
                  ? CustomTextFieldUpdate(
                      controller: releaseDateController,
                      hintText: "this is release Date",
                      label: movie.releaseDate.toString(),
                      readOnly: false,
                    )
                  : CustomTextFieldUpdate(
                      controller: durationController,
                      hintText: "",
                      label: "",
                      readOnly: false,
                    ),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                controller: categoryController,
                hintText: "this is category ",
                readOnly: false,
              ),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                controller: actorController,
                hintText: "this is actor ",
                readOnly: false,
              ),
              const SizedBox(height: 20),
              movie.description != null
                  ? CustomTextFieldUpdate(
                      controller: descriptionController,
                      hintText: "this is description ",
                      label: movie.description,
                      readOnly: false,
                    )
                  : CustomTextFieldUpdate(
                      controller: descriptionController,
                      hintText: "",
                      label: "",
                      readOnly: false,
                    ),
              const SizedBox(height: 20),
              BlocConsumer<MovieBloc, MovieState>(
                listener: (context, state) {
                  if (state is MovieErrorState) {
                    showToastFailed(context, state.error);
                    print(state.error);
                  }
                },
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is MovieLoadedState) {
                    return ElevatedButton(
                      onPressed: () {
                        String actorString =
                            "[6596fa7bb733b079b18f2dd2 ,  6596fc06b733b079b18f2de0]";
                        String categoryString = "[romance ,  action]";

                        actorString = actorController.text
                            .trim()
                            .replaceAll("[", "")
                            .replaceAll("]", "");
                        categoryString = categoryController.text
                            .trim()
                            .replaceAll("[", "")
                            .replaceAll("]", "");

                        List<Object> actorList = actorString
                            .split(',')
                            .map((e) => e.trim())
                            .toList();
                        List<String> categoryList = categoryString
                            .split(',')
                            .map((e) => e.trim())
                            .toList();

                          context.read<MovieBloc>().add(UpdateMovieEvent(
                              actor: actorList,
                              category: categoryList,
                              title: titleController.text.trim().isNotEmpty
                                  ? titleController.text.trim()
                                  : movie.title,
                              release_date:
                                  releaseDateController.text.trim().isNotEmpty
                                      ? releaseDateController.text.trim()
                                      : movie.releaseDate.toString(),
                              duration:
                                  durationController.text.trim().isNotEmpty
                                      ? durationController.text.trim()
                                      : movie.duration.toString(),
                              description: descriptionController.text.trim(),
                              movieId: movie.id,
                              context: context));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xffF34C30), Color(0xffDA004E)]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          width: 335,
                          height: 60,
                          alignment: Alignment.center,
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
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
