import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_booking_app/admin/movie/widgets/custom_text_field_add.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:get/get.dart' as Getx;
import 'package:movie_booking_app/profile/widgets/custom_text_field_update.dart';

class AddNewMovieAdmin extends StatefulWidget {
  const AddNewMovieAdmin({super.key});

  @override
  State<AddNewMovieAdmin> createState() => _AddNewMovieAdminState();
}

class _AddNewMovieAdminState extends State<AddNewMovieAdmin> {
  File? pickedImage;
  File? pickedVideo;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController releaseDateController = TextEditingController();
    TextEditingController durationController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController actorController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
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
          // print(pickedImage);
        });
      } else {
        print("File path is null.");
      }
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white54,
        backgroundColor: Constants.bgColorAdmin,
        title: const Text("Add new Movie"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 50),
            child: InkWell(
                onTap: () {
                  Getx.Get.defaultDialog(
                    title: "INFORMATION!",
                    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                    middleText:
                        "Status is for active or inactive a movie! true is active and false is inactive",
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
                      ? Image.file(File(pickedImage!.path),width: 200,height: 200,)
                      : Expanded(
                          child: CustomTextFieldAdd(
                              controller: imageController,
                              hintText: "Pick a image",
                              readOnly: true),
                        ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  controller: titleController,
                  hintText: "Write title",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  controller: releaseDateController,
                  hintText: "Write release date",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  controller: durationController,
                  hintText: "Write duration",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  controller: categoryController,
                  hintText: "Write category",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  controller: actorController,
                  hintText: "Write actor",
                  readOnly: false),
              const SizedBox(height: 20),
              CustomTextFieldAdd(
                  controller: descriptionController,
                  hintText: "Write description",
                  readOnly: false),
            ],
          ),
        ),
      ),
    );
  }
}
