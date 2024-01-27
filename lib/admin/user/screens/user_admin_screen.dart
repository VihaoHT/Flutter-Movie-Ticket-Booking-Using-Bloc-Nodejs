import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/ultis.dart';
import 'package:movie_booking_app/core/respository/users_respository.dart';
import 'package:movie_booking_app/models/user_model.dart';

import '../../../core/components/header_admin.dart';
import '../../../core/constants/constants.dart';
import '../users_bloc/users_bloc.dart';

class UserAdminScreen extends StatefulWidget {
  const UserAdminScreen({super.key});

  @override
  State<UserAdminScreen> createState() => _UserAdminScreenState();
}

class _UserAdminScreenState extends State<UserAdminScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderAdmin(title: "All User"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 500,
              color: Constants.bgColorAdmin,
              child: TextField(
                onChanged: (value) async {

                  if(context.mounted) {
                   context.read<UsersBloc>().add(SearchLoadUserEvent(name: value));
                  }
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Write username u wanna find",
                  labelStyle: const TextStyle(color: Colors.white),
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          BlocConsumer<UsersBloc, UsersState>(
            listener: (context, state) {
              if (state is UserErrorState) {
                showToastFailed(context, "Failed to load users ${state.error}");
                print(state.error);
              }
            },
            builder: (context, state) {
              if (state is UserLoadedState) {
                List<User> userList = state.users;
                return Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      // TextFormField(
                      //   style: const TextStyle(
                      //       color: Colors.white
                      //   ),
                      //   controller: searchController,
                      //   decoration:  InputDecoration(
                      //     hintText: "",
                      //     labelText: "",
                      //     labelStyle: const TextStyle(
                      //         color: Colors.white, // Màu sắc của label text
                      //         fontWeight: FontWeight.bold   // Kích thước của label text
                      //     ),
                      //     // label:  Text(label,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      //     hintStyle: const TextStyle(color: Colors.white),
                      //     border: const OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.black),
                      //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      //     ),
                      //     suffixIcon: InkWell(onTap: () {
                      //       context.read<UsersBloc>().add(SearchLoadUserEvent(name: searchController.text.trim()));
                      //     },child: const Icon(Icons.search))
                      //   ),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: userList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Constants.bgColorAdmin,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: userList[index].avatar != null
                                          ? Image.network(
                                              userList[index].avatar!,
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset(
                                              Constants.avatarDefaultPath,
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(14.0),
                                              child: Text(
                                                "Email :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              userList[index].email,
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
                                                "Username :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              userList[index].username,
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
                                                "Role  :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              userList[index].role,
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
                                                "Phone Number :",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            userList[index].phone_number != null
                                                ? Text(
                                                    userList[index]
                                                        .phone_number!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                : const Text(
                                                    "Null (The user not provide phone number yet)",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer()
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
    )));
  }
}
