import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as Getx;
import 'package:intl/intl.dart';
import 'package:movie_booking_app/admin/showtime/screens/add_new_showtime.dart';
import 'package:movie_booking_app/admin/showtime/showtime_bloc/showtime_bloc.dart';
import 'package:movie_booking_app/models/showtime_model.dart';
import '../../../core/components/header_admin.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/ultis.dart';

class ShowtimeAdminScreen extends StatelessWidget {
  const ShowtimeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const HeaderAdmin(title: "Showtime Manager"),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.red,
                  hoverColor: Colors.white54,
                  onTap: () {
                    Getx.Get.to(() => (const AddNewShowtime()),
                        transition: Getx.Transition.cupertino,
                        duration: const Duration(seconds: 2));
                  },
                  child: Container(
                    width: 195,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.bgColorAdmin,
                    ),
                    child: const ListTile(
                      title: Text(
                        "Add new Showtime",
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
                          context
                              .read<ShowtimeBloc>()
                              .add(LoadSearchShowtimeEvent(title: value));
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Write the showtime movie name u wanna find",
                        labelStyle: const TextStyle(color: Colors.white),
                        suffix: InkWell(
                            onTap: () {
                              searchController.clear();
                              context.read<ShowtimeBloc>().add(
                                  const LoadSearchShowtimeEvent(title: ""));
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
            BlocConsumer<ShowtimeBloc, ShowtimeState>(
              listener: (context, state) {
                if (state is ShowtimeErrorState) {
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
                if (state is ShowtimeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ShowtimeLoadedState) {
                  List<ShowTime> showtimeList = state.showtimes;
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: showtimeList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var startTime =
                            showtimeList[index].startTime.toString();
                        var endTime = showtimeList[index].endTime.toString();
                        var price = showtimeList[index].price;

                        //date format
                        DateTime starttime = DateTime.parse(startTime);
                        String formattedStartTime =
                            DateFormat('HH:mm:ss').format(starttime);
                        DateTime endtime = DateTime.parse(endTime);
                        String formattedEndTime =
                            DateFormat('HH:mm:ss').format(endtime);

                        //price format
                        String formattedPrice = NumberFormat.currency(
                                locale: 'vi_VN', symbol: 'VND')
                            .format(price);

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
                                            "Showtime ID  :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          showtimeList[index].id,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: InkWell(
                                              onTap: () {
                                                // this is for copy text
                                                Clipboard.setData(ClipboardData(
                                                    text: showtimeList[index]
                                                        .id
                                                        .toString()));
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
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          showtimeList[index].room.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
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
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          showtimeList[index].room.cinema.name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Text(
                                            "Cinema address :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 500,
                                          child: Text(
                                            showtimeList[index]
                                                .room
                                                .cinema
                                                .location
                                                .address,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Text(
                                            "Movie title  :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          showtimeList[index].movie.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: InkWell(
                                              onTap: () {
                                                // this is for copy text
                                                Clipboard.setData(ClipboardData(
                                                    text: showtimeList[index]
                                                        .movie
                                                        .title));
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
                                            "Start time :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          formattedStartTime,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Text(
                                            "End time :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          formattedEndTime,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(14.0),
                                          child: Text(
                                            "Price :",
                                            style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          formattedPrice,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.deepPurple,
                                  ),
                                  child: ListTile(
                                    onTap: () {},
                                    title: const Text(
                                      "Details",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
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
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
