import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/seat/screens/seat_screen.dart';
import 'package:get/get.dart' as Getx;
import '../../auth/bloc/auth_bloc.dart';

class ShowTimeScreen extends StatelessWidget {
  final String id;
  final String title;

  const ShowTimeScreen({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> fetchData() async {
      final response = await get(Uri.parse("$uri/api/showtimes?cinema=$id"));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data']['showtimes'];
        if (responseData is List) {
          return responseData;
        } else {
          // If the data is not in the expected format, throw an exception
          throw Exception('Invalid data format');
        }
      } else {
        // Nếu không thành công, ném một ngoại lệ
        throw Exception('Failed to load data');
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      Constants.back2Path,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 80, top: 10),
                  child: const Text(
                    'Choose the time',
                    style: TextStyle(
                      color: Constants.colorTitle,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Display loading for data waiting
                } else if (snapshot.hasError) {
                  //print(snapshot.error);
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<dynamic> showtimes = snapshot.data as List<dynamic>;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: showtimes.length,
                      itemBuilder: (context, index) {
                        var showtime = showtimes[index];
                        // var movieTitle = showtime['movie']['title'];
                        var startTime = showtime['start_time'];
                        var endTime = showtime['end_time'];
                        var price = showtime['price'];
                        var roomName = showtime['room']['name'];

                        //date format
                        DateTime date = DateTime.parse(startTime);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(date);

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

                        return BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            // print((state as AuthSuccess).user.id);
                            return GestureDetector(
                              onTap: () {
                                Getx.Get.to(()=>
                                    SeatScreen(
                                      item: showtime,
                                      userId: (state as AuthSuccess).user.id,
                                    ),
                                    transition: Getx.Transition.fade,
                                    duration:
                                        const Duration(milliseconds: 1000));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 21, right: 19),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff201934),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 17),
                                              child: Text(
                                                "Date: $formattedDate",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              formattedPrice,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.only(left: 17),
                                        child: Text(
                                          "Time: $formattedStartTime - $formattedEndTime",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.only(left: 17),
                                        child: Text(
                                          "Room: $roomName",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                            left: 13,
                                          ),
                                          child:
                                              Image.asset(Constants.line2Path)),
                                    ],
                                  )),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
