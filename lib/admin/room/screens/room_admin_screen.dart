import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;
import 'package:movie_booking_app/admin/room/screens/add_new_room.dart';
import '../../../core/components/header_admin.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/ultis.dart';
import '../../../models/room_model.dart';
import '../room_bloc/room_bloc.dart';

class RoomAdminScreen extends StatelessWidget {
  const RoomAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const HeaderAdmin(title: "Room Manager"),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.red,
                  hoverColor: Colors.white54,
                  onTap: () {
                    Getx.Get.to(() => (const AddNewRoom()),
                        transition: Getx.Transition.cupertino,
                        duration: const Duration(seconds: 2));
                  },
                  child: Container(
                    width: 195,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.bgColorAdmin,
                    ),
                    child: const ListTile(
                      title: Text(
                        "Add new Room",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 500,
                    color: Constants.bgColorAdmin,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) async {
                        if (context.mounted) {
                          context.read<RoomBloc>().add(LoadSearchRoomEvent(id: value));
                        }
                      },

                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Write the room id u wanna find",
                        labelStyle: const TextStyle(color: Colors.white),
                        suffix: InkWell(
                            onTap: () {
                              searchController.clear();
                              context.read<RoomBloc>().add(const LoadSearchRoomEvent(id: ""));
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _roomListBuilder(),
          ],
        ),
      ),
    ));
  }

  BlocConsumer<RoomBloc, RoomState> _roomListBuilder() {
    return BlocConsumer<RoomBloc, RoomState>(
            listener: (context, state) {
              if (state is RoomErrorState) {
                showToastFailed(
                    context, "Failed to load data ${state.error.toString()}");
                Text(
                  state.error.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                );
              }
            },
            builder: (context, state) {
              if (state is RoomLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is RoomLoadedState) {
                List<Room> roomList = state.room;
                return Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: roomList.length,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(14.0),
                                        child: Text(
                                          "Room ID  :",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        roomList[index].id,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: InkWell(
                                            onTap: () {
                                              // this is for copy text
                                              Clipboard.setData(ClipboardData(
                                                  text: roomList[index].id));
                                              showToastSuccess(
                                                  context, "Copied");
                                            },
                                            child: Image.asset(
                                              Constants.copyPath,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(14.0),
                                        child: Text(
                                          "Room name :",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        roomList[index].name,
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
                                          "Cinema ID :",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        roomList[index].cinema.id,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: InkWell(
                                            onTap: () {
                                              // this is for copy text
                                              Clipboard.setData(ClipboardData(
                                                  text: roomList[index]
                                                      .cinema
                                                      .id));
                                              showToastSuccess(
                                                  context, "Copied");
                                            },
                                            child: Image.asset(
                                              Constants.copyPath,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(14.0),
                                        child: Text(
                                          "Cinema name :",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        roomList[index].cinema.name,
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
                                          "Room name :",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1000,
                                        child: Text(
                                          roomList[index].cinema.location.address,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          );
  }
}
