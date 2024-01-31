import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;
import '../../../core/constants/constants.dart';
import '../../movie/widgets/custom_text_field_add.dart';
import '../cinema_bloc/cinema_bloc.dart';

class AddNewCinema extends StatelessWidget {
  const AddNewCinema({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController coordinatesController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    List<double> parseCoordinates(String input) {
      // split , and turn into a list double
      List<String> parts = input.split(',');
      List<double> coordinates =
          parts.map((e) => double.tryParse(e.trim()) ?? 0.0).toList();
      return coordinates;
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white54,
        backgroundColor: Constants.bgColorAdmin,
        title: const Text("Add new Cinema"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 50),
            child: InkWell(
                onTap: () {
                  Getx.Get.defaultDialog(
                    title: "INFORMATION!",
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                    middleText:
                        "Longitude and latitude can be find on google map!",
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
              CustomTextFieldAdd(
                  labelText: "Write name",
                  controller: nameController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  labelText:
                      "example longitude : 106.62834197268958, latitude: 10.750100092180903",
                  controller: coordinatesController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  labelText: "Write address",
                  controller: addressController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              BlocConsumer<CinemaBloc, CinemaState>(
                listener: (context, state) {
                  if (state is CinemaErrorState) {
                    print(state.error);
                  }
                },
                builder: (context, state) {
                  if (state is CinemaLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CinemaLoadedState) {
                    return ElevatedButton(
                      onPressed: () {
                        String input = coordinatesController.text;
                        List<double> coordinates = parseCoordinates(input);

                        context.read<CinemaBloc>().add(PostCinemaEvent(
                            name: nameController.text.trim(),
                            coordinates: coordinates,
                            address: addressController.text.trim(),
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
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
