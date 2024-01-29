import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;
import '../../../core/constants/constants.dart';
import '../../movie/widgets/custom_text_field_add.dart';
import 'package:intl/intl.dart';
class AddNewShowtime extends StatefulWidget {
  const AddNewShowtime({super.key});

  @override
  State<AddNewShowtime> createState() => _AddNewShowtimeState();
}

class _AddNewShowtimeState extends State<AddNewShowtime> {
  @override
  Widget build(BuildContext context) {
    TextEditingController movieIdController = TextEditingController();
    TextEditingController roomIdController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();
    DateTime selectedDateTime = DateTime.now();

    Future<void> _selectDateTime(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != selectedDateTime) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDateTime),
        );

        if (pickedTime != null) {
          setState(() {
            selectedDateTime = DateTime(
              picked.year,
              picked.month,
              picked.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white54,
        backgroundColor: Constants.bgColorAdmin,
        title: const Text("Add new Showtime"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 50),
            child: InkWell(
                onTap: () {
                  Getx.Get.defaultDialog(
                    title: "INFORMATION!",
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                    middleText:
                    "",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldAdd(
                  labelText: "Write movie ID",
                  controller: movieIdController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  labelText:
                  "Write room ID",
                  controller: roomIdController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  labelText: "Write price example : 70000",
                  controller: priceController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              // CustomTextFieldAdd(
              //     labelText: "Select start time",
              //     controller: startTimeController,
              //     hintText: "",
              //     readOnly: true),
              // const SizedBox(height: 20),
              // CustomTextFieldAdd(
              //     labelText: "Select end time",
              //     controller: endTimeController,
              //     hintText: "",
              //     readOnly: true),
              // const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Selected Start time:',
                          style: TextStyle(fontSize: 16,color: Colors.white),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            print(selectedDateTime);
                            _selectDateTime(context);
                          },
                          child: const Text('Select Start time'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // BlocConsumer<CinemaBloc, CinemaState>(
              //   listener: (context, state) {
              //     if (state is CinemaErrorState) {
              //       print(state.error);
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state is CinemaLoadingState) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //     if (state is CinemaLoadedState) {
              //       return ElevatedButton(
              //         onPressed: () {
              //           String input = coordinatesController.text;
              //           List<double> coordinates = parseCoordinates(input);
              //
              //           context.read<CinemaBloc>().add(PostCinemaEvent(
              //               name: nameController.text.trim(),
              //               coordinates: coordinates,
              //               address: addressController.text.trim(),
              //               context: context));
              //         },
              //         style: ElevatedButton.styleFrom(
              //             padding: EdgeInsets.zero,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(20))),
              //         child: Ink(
              //           decoration: BoxDecoration(
              //               gradient: const LinearGradient(
              //                   colors: [Color(0xffF34C30), Color(0xffDA004E)]),
              //               borderRadius: BorderRadius.circular(20)),
              //           child: Container(
              //             width: 335,
              //             height: 60,
              //             alignment: Alignment.center,
              //             child: const Text(
              //               'Confirm',
              //               style: TextStyle(
              //                   fontSize: 17,
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.white),
              //             ),
              //           ),
              //         ),
              //       );
              //     }
              //     return const SizedBox();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
