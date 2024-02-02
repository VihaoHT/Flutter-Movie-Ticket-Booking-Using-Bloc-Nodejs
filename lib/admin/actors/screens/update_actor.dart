import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/models/actor_model.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/ultis.dart';
import '../../movie/widgets/custom_text_field_add.dart';
import '../bloc/actor_bloc.dart';

class UpdateActor extends StatefulWidget {
  final Actor actor;

  const UpdateActor({super.key, required this.actor});

  @override
  State<UpdateActor> createState() => _UpdateActorState();
}

class _UpdateActorState extends State<UpdateActor> {
  File? pickedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController dobDateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  pickImageFromFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(dialogTitle: "Pick a image for the Movie!");
    if (result == null) return;

    PlatformFile file = result.files.single;
    // print(file.path);
    if (file.path != null) {
      setState(() {
        pickedImage = File(file.path!);
      });
    } else {
      print("File path is null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var dob = widget.actor.dob;
    DateTime dobDate = DateTime.parse(dob);
    String formattedDob = DateFormat('yyyy/MM/dd').format(dobDate);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white54,
        backgroundColor: Constants.bgColorAdmin,
        title: Text("Update Actor ${widget.actor.name}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        pickImageFromFile();
                      },
                      child: Image.asset(
                        Constants.addImagePath,
                        width: 50,
                        height: 50,
                      )),
                  pickedImage != null
                      ? Image.file(
                    File(pickedImage!.path),
                    width: 200,
                    height: 200,
                  )
                      : Expanded(
                    child: CustomTextFieldAdd(
                        labelText: "Pick a image (Avatar actor cannot be null)",
                        controller: imageController,
                        hintText: "Press the image right to add image",
                        readOnly: true),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              widget.actor.name.isNotEmpty
                  ? CustomTextFieldAdd(
                      labelText: widget.actor.name,
                      controller: nameController,
                      hintText: "Actor Name",
                      readOnly: false)
                  : CustomTextFieldAdd(
                      labelText: "Write actor name",
                      controller: nameController,
                      hintText: "",
                      readOnly: false),
              const SizedBox(height: 20),
              widget.actor.dob.isNotEmpty
                  ? CustomTextFieldAdd(
                      labelText: formattedDob,
                      controller: dobDateController,
                      hintText: "Actor Dob example : month-day-year",
                      readOnly: false)
                  : CustomTextFieldAdd(
                      labelText: "Write actor DOB",
                      controller: dobDateController,
                      hintText: "",
                      readOnly: false),
              const SizedBox(height: 20),
              widget.actor.country.isNotEmpty
                  ? CustomTextFieldAdd(
                      labelText: widget.actor.country,
                      controller: countryController,
                      hintText: "Actor Country",
                      readOnly: false)
                  : CustomTextFieldAdd(
                      labelText: "Write actor country",
                      controller: countryController,
                      hintText: "",
                      readOnly: false),
              const SizedBox(height: 20),
              BlocConsumer<ActorBloc, ActorState>(
                listener: (context, state) {
                  if (state is ActorErrorState) {
                    showToastFailed(context, state.error);
                    //print(state.error);
                  }
                },
                builder: (context, state) {
                  if (state is ActorLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ActorLoadedState) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<ActorBloc>().add(UpdateActorsEvent(
                            avatar: pickedImage!,
                            name: nameController.text.trim().isNotEmpty
                                ? nameController.text.trim()
                                : widget.actor.name,
                            dob: dobDateController.text.trim().isNotEmpty
                                ? dobDateController.text.trim()
                                : widget.actor.dob,
                            country: countryController.text.trim().isNotEmpty
                                ? countryController.text.trim()
                                : widget.actor.country,
                            actorID: widget.actor.id,
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
