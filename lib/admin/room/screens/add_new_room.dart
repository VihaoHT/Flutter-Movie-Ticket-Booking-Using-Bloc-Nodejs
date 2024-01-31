import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../movie/widgets/custom_text_field_add.dart';
import '../room_bloc/room_bloc.dart';

class AddNewRoom extends StatelessWidget {
  const AddNewRoom({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController roomNameController = TextEditingController();
    TextEditingController cinemaIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white54,
        backgroundColor: Constants.bgColorAdmin,
        title: const Text("Add new Room"),
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 50),
        //     child: InkWell(
        //         onTap: () {
        //           Getx.Get.defaultDialog(
        //             title: "INFORMATION!",
        //             titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        //             middleText:
        //             "Longitude and latitude can be find on google map!",
        //             middleTextStyle: const TextStyle(
        //                 color: Constants.colorTitle,
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w700),
        //           );
        //         },
        //         child: Image.asset(
        //           Constants.informationPath,
        //           color: Colors.white54,
        //         )),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFieldAdd(
                  labelText: "Write room name",
                  controller: roomNameController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  labelText: "Write cinema ID ",
                  controller: cinemaIdController,
                  hintText: "",
                  readOnly: false),
              const SizedBox(height: 20),
              BlocConsumer<RoomBloc, RoomState>(
                listener: (context, state) {
                  if (state is RoomErrorState) {
                    print(state.error);
                  }
                },
                builder: (context, state) {
                  if (state is RoomLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is RoomLoadedState) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<RoomBloc>().add(AddRoomEvent(
                            roomName: roomNameController.text.trim(),
                            cinemaId: cinemaIdController.text.trim(),
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
