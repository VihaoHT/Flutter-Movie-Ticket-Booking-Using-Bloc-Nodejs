import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/profile/screens/detail_my_ticket_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../core/constants/constants.dart';
import 'package:get/get.dart' as GetX;
class MyTicketScreen extends StatelessWidget {
  const MyTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> fetchMyTicket() async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? token = preferences.getString('token');
        String apiMyTicket = "$uri/api/tickets/user";
        final response = await get(
          Uri.parse(apiMyTicket),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final List<dynamic> tickets = data['data']['tickets'];
          return tickets;
        } else {
          print(response.statusCode);
          throw Exception('Invalid data format');
        }
      } catch (e) {
        throw Exception('Invalid data format' + e.toString());
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 29, top: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      Constants.backPath,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 130, top: 20),
                  child: const Text(
                    "My Ticket",
                    style: TextStyle(
                      color: Constants.colorTitle,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FutureBuilder(
                  future: fetchMyTicket(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<dynamic> tickets = snapshot.data as List<dynamic>;
                      if (tickets.isEmpty) {
                        return const Text(
                          'No tickets available.',
                          style: TextStyle(fontSize: 33, color: Colors.white),
                        );
                      }
                      return SizedBox(
                        width: 390,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var item = snapshot.data?[index];
                            var imageMovie =
                                item['showtime']['movie']['imageCover'];
                            var titleMovie = item['showtime']['movie']['title'];
                            var date = item['showtime']['start_time'];
                            var seat = item['seats'];

                            //check if seat length greater than or equal 3 will have ,...
                            var checkSeats = seat.length >= 3
                                ? seat.join(", ") + ",..."
                                : seat.join(", ");

                            //format date
                            //change this to en_US if you in US
                            initializeDateFormatting('vi_VN');
                            DateTime dateTime = DateTime.parse(date);
                            String formattedDate =
                                DateFormat('EEEE dd-MM-yyyy', 'vi_VN')
                                    .format(dateTime);

                            //format time
                            String formattedTime =
                                DateFormat.jm('vi_VN').format(dateTime);

                            return Padding(
                              padding: const EdgeInsets.only(top: 26, left: 20),
                              child: InkWell(
                                onTap: () {
                                  GetX.Get.to(()=> DetailMyTicketScreen(ticketItem: snapshot.data?[index]),transition: GetX.Transition.cupertino,duration: const Duration(seconds: 1));
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        imageMovie,
                                        width: 142,
                                        height: 106,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              titleMovie,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Date: ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: formattedDate,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'Time: ',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          formattedTime + "   |",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      const TextSpan(
                                                        text: 'Seat:  ',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: checkSeats,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
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
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
