import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;
import 'package:movie_booking_app/core/constants/ultis.dart';
import '../../../core/constants/constants.dart';
import '../../movie/widgets/custom_text_field_add.dart';
import 'package:intl/intl.dart';

import '../showtime_bloc/showtime_bloc.dart';

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
    DateTime? selectedStartTime;
    DateTime? selectedEndTime;
    // DateTime selectedDateTime0;

    Future pickStartTime() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            selectedStartTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          });
          showToastSuccess(context,
              'start time picked: ${DateFormat('yyyy-MM-dd HH:mm:ss.000').format(selectedStartTime!)}');
          // print(
          //     'start time picked: ${DateFormat('yyyy-MM-ddTHH:mm:ss.000').format(selectedDateTime)}');
        }
      }
    }

    Future pickEndTime() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            selectedEndTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          });
          showToastSuccess(context,
              'end time picked: ${DateFormat('yyyy-MM-dd HH:mm:ss.000').format(selectedEndTime!)}');
          // print(
          //     'start time picked: ${DateFormat('yyyy-MM-ddTHH:mm:ss.000').format(selectedDateTime)}');
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
                    middleText: "",
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
                  labelText: "Write room ID",
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
              CustomTextFieldAdd(
                  labelText: "Write start time example : 2023-12-30T08:30:00.000",
                  controller: startTimeController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  labelText: "Write end time example : 2023-12-30T09:30:00.000",
                  controller: endTimeController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     SizedBox(
              //       width: 200,
              //       height: 50,
              //       child: ElevatedButton(
              //         onPressed: () {
              //           pickStartTime();
              //         },
              //         child: const Text("Choose start time"),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 200,
              //       height: 50,
              //       child: ElevatedButton(
              //         onPressed: () {
              //           pickEndTime();
              //         },
              //         child: const Text("Choose end time"),
              //       ),
              //     ),
              //   ],
              // ),
              BlocConsumer<ShowtimeBloc, ShowtimeState>(
                listener: (context, state) {
                  if (state is ShowtimeErrorState) {
                    print(state.error);
                  }
                },
                builder: (context, state) {
                  if (state is ShowtimeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ShowtimeLoadedState) {
                    return ElevatedButton(
                      onPressed: () {
                        print(movieIdController.text.trim());
                        print(roomIdController.text.trim());
                        context.read<ShowtimeBloc>().add(AddShowtimeEvent(
                            movieId: movieIdController.text.trim(),
                            roomId: roomIdController.text.trim(),
                            startTime:startTimeController.text.trim(),
                            endTime: endTimeController.text.trim(),
                            price: int.parse(priceController.text.trim()),
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
