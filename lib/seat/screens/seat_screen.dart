import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/core/constants/ultis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom_navigation.dart';
import '../../core/constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../models/user_model.dart';

class SeatScreen extends StatefulWidget {
  final dynamic item;
  final String userId;

  const SeatScreen({super.key, required this.item, required this.userId});

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  List<String> selectedSeats = [];
  List<String> mySeats = [];
  List<String> specialSeats = [];
  List<User>? user;

  final List<String> seats = [
    "A1",
    "A2",
    "A3",
    "A4",
    "A5",
    "A6",
    "A7",
    "A8",
    "B1",
    "B2",
    "B3",
    "B4",
    "B5",
    "B6",
    "B7",
    "B8",
    "C1",
    "C2",
    "C3",
    "C4",
    "C5",
    "C6",
    "C7",
    "C8",
    "D1",
    "D2",
    "D3",
    "D4",
    "D5",
    "D6",
    "D7",
    "D8",
    "E1",
    "E2",
    "E3",
    "E4",
    "E5",
    "E6",
    "E7",
    "E8",
    "F1",
    "F2",
    "F3",
    "F4",
    "F5",
    "F6",
    "F7",
    "F8",
    "G1",
    "G2",
    "G3",
    "G4",
    "G5",
    "G6",
    "G7",
    "G8",
    "H1",
    "H2",
    "H3",
    "H4",
    "H5",
    "H6",
    "H7",
    "H8",
  ];

  // this is for seats select
  void toggleSeatSelection(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);

      }
    });
  }

  // Check out payment
  checkoutSelectedSeats() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    final response = await post(
        Uri.parse(
            '$uri/api/tickets/checkout/${widget.item['_id']}'),
        body: jsonEncode({
          'seats': selectedSeats,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: data['paymentIntent'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'BEENEMA'));
      displayPaymentSheet();
      //print(data);
    } else {
      // if user dont pick any seat then toast failed
      if(context.mounted) {
        showToastFailed(context, 'You forgot to pick up seats!');
      }
      //print('Checkout failed');
    }
  }
  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      await post(
          Uri.parse(
              '$uri/api/tickets/checkout/${widget.item['_id']}/create-ticket'),
          body: jsonEncode({
            'seat_number': selectedSeats,
          }),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      if(context.mounted) {
        showToastSuccess(context, 'Payment Successfully!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigation(),
          ),
              (route) => false,
        );
      }
    } on Exception catch (e) {
      if (e is StripeException) {
        // if(context.mounted) {
        //   showToastFailed(context, 'Error from Stripe: ${e.error.localizedMessage}');
        // }
      } else {
        if(context.mounted) {
          showToastFailed(context,  'Unforeseen error: ${e}');
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var startTime = widget.item['start_time'];
    var endTime = widget.item['end_time'];

    DateTime date = DateTime.parse(startTime);
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    DateTime starttime = DateTime.parse(startTime);
    String formattedStartTime = DateFormat('HH:mm:ss').format(starttime);
    DateTime endtime = DateTime.parse(endTime);
    String formattedEndTime = DateFormat('HH:mm:ss').format(endtime);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      child: Image.asset(
                        Constants.back2Path,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 80, top: 10),
                    child: const Text(
                      'Choose seat',
                      style: TextStyle(
                        color: Constants.colorTitle,
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(left: 33),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.item['movie']['imageCover'],
                        width: 105,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Constants.movieimagePath,
                                width: 24,
                                height: 24,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                width: 200,
                                child: Text(
                                  widget.item['movie']['title'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(Constants.locationPath,
                                  width: 24, height: 24),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                width: 200,
                                child: Text(
                                  widget.item['room']['name'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(Constants.datePath,
                                  width: 24, height: 24),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                width: 200,
                                child: Text(
                                  "$formattedDate: $formattedStartTime - $formattedEndTime",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // Vô hiệu hóa khả năng cuộn
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8, // Số cột trong một hàng
                    crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                    mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                  ),
                  itemCount: seats.length,
                  itemBuilder: (context, index) {
                    final seat = seats[index];
                    final isSelected = selectedSeats.contains(seat);

                    return GestureDetector(
                      onTap: () {
                        toggleSeatSelection(seat);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            seat,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Image.asset(Constants.avaiablePath),
                        const Text(
                          "Available seats",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Image.asset(Constants.paidPath),
                        const Text(
                          "Paid seats",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Image.asset(Constants.myPath),
                        const Text(
                          "My seats selecting",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    checkoutSelectedSeats();
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
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Image.asset(Constants.cartPath)),
                        Container(
                          margin: const EdgeInsets.only(left: 80),
                          height: 60,
                          alignment: Alignment.center,
                          child: const Text(
                            'Continue->',
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
            ],
          ),
        ),
      ),
    );
  }
}
