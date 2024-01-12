import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_booking_app/core/constants/ultis.dart';
import 'package:movie_booking_app/profile/widgets/custom_text_field_update.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../core/constants/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  XFile? pickedFile;
  String? newAvatarPath;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> updateImage(XFile? pickedFile) async {
    try {
      Dio dio = Dio();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      if (pickedFile != null) {
        // Use the correct Content-Type header
        final options = Options(
          headers: {
            'Content-Type': 'application/json' 'multipart/form-data',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        FormData formData = FormData.fromMap({
          'avatar': await MultipartFile.fromFile(
            pickedFile.path,
          ),
        });

        Response response = await dio.post(
          'http://192.168.2.6:3000/api/users/update-user-avatar',
          data: formData,
          options: options,
        );
        if (response.statusCode == 201) {
          /// NOTICE : IN THIS API I JUST SAVE THE FILE IMAGE TO STRING TO PASTE IT INTO AVATAR IN BLOC EVENT UpdateProfileButtonPressed
          /// NOTICE: IF IN CLIENT IS 201 AND THE SERVER SEND ERROR  Cannot set headers after they are sent to the client 403 just ignore it, IT FINE
          print('Image upload succesfully');
          newAvatarPath = response.data['avatar'].toString();
          print(newAvatarPath);
        } else {
          print('Image upload failed');
          print(response.statusCode);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    pickImageFromGallery() async {
      final picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        updateImage(pickedFile);
      });
    }

    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            print(state.error);
            showToastFailed(context, state.error);
          }
          if (state is AuthSuccess) {
            showToastSuccess(context, "Update Profile successfully! Pls login again");
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 29, top: 20),
                          child: Image.asset(
                            Constants.backPath,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 100, top: 20),
                        child: const Text(
                          "Update Profile",
                          style: TextStyle(
                            color: Constants.colorTitle,
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  pickedFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(180.0),
                          child: Image.file(
                            File(pickedFile!.path),
                            width: 180,
                            height: 180,
                            fit: BoxFit.fill,
                          ))
                      : InkWell(
                          onTap: () {
                            pickImageFromGallery();
                          },
                          child: Column(
                            children: [
                              (state is AuthSuccess &&
                                      state.user.avatar != null)
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(180.0),
                                      child: Image.network(
                                        state.user.avatar!,
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(180.0),
                                      child: Image.asset(
                                        Constants.avatarDefaultPath,
                                        width: 180,
                                        height: 180,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 20),
                  Column(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 33, left: 42),
                      child: const Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    (state is AuthSuccess && state.user.email != null)
                        ? CustomTextFieldUpdate(
                            controller: emailController,
                            hintText: "",
                            label: state.user.email,
                            readOnly: true,
                          )
                        : CustomTextFieldUpdate(
                            controller: emailController,
                            hintText: "",
                            label: "",
                            readOnly: true,
                          )
                  ]),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 42),
                        child: const Text(
                          "Username",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                      (state is AuthSuccess && state.user.username != null)
                          ? CustomTextFieldUpdate(
                              controller: usernameController,
                              hintText: "",
                              label: state.user.username,
                              readOnly: false,
                            )
                          : CustomTextFieldUpdate(
                              controller: usernameController,
                              hintText: "",
                              label: "cc",
                              readOnly: false,
                            )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 42),
                        child: const Text(
                          "Phone number",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                      (state is AuthSuccess && state.user.phone_number != null)
                          ? CustomTextFieldUpdate(
                              controller: phoneNumberController,
                              hintText: "",
                              label: state.user.phone_number!,
                              readOnly: false,
                            )
                          : CustomTextFieldUpdate(
                              controller: phoneNumberController,
                              hintText: "",
                              label: "",
                              readOnly: false,
                            )
                    ],
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              UpdateProfileButtonPressed(
                                pickedFile != null
                                    ? newAvatarPath
                                    : (state as AuthSuccess).user.avatar,
                                usernameController.text.trim().isNotEmpty
                                    ? usernameController.text.trim()
                                    : (state as AuthSuccess).user.username,
                                phoneNumberController.text.trim().isNotEmpty
                                    ? phoneNumberController.text.trim()
                                    : (state as AuthSuccess).user.phone_number,
                              ),
                            );
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                    left: 33,
                                  ),
                                  child: Image.asset(Constants.savePath)),
                              Container(
                                margin: const EdgeInsets.only(right: 120),
                                child: const Text(
                                  'Save Profile',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
