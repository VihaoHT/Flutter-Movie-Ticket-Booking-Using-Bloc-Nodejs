import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../models/user_model.dart';

class SeatScreen extends StatefulWidget {
  final dynamic item;
  final String userId;
  const SeatScreen({super.key, required this.item,required this.userId});

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  static const host = "http://192.168.2.6:3000";
  final socket = io.io(host);
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

  @override
  void initState() {
    super.initState();
    print(widget.userId);


    socket.onConnect((_) {
      print('Connected');
    });

    // Gửi sự kiện "joinRoom" với mã showtimeId
    socket.emit('joinRoom', widget.item['_id']);

    // Lắng nghe sự kiện "seat_changed"
    socket.on('seat_changed', (dataGot) {
      // Xử lý dữ liệu khi có thay đổi về ghế ngồi
      if (dataGot.length == 0) {
        // Không có ai chọn ghế
        selectedSeats = [];
        mySeats = [];
        return;
      }
      // Xử lý dữ liệu khi có thay đổi về ghế ngồi

    });
  }

  // Hàm để lọc các ghế đã đặt
  List<String> filterReservedSeats(List<dynamic> arr) {
    // Filter seats with "reserved" status:
    final reservedSeats = arr.where((item) => item['status'] == 'reserved').toList();

    // Return either reserved seat numbers or special seats:
    return reservedSeats.isNotEmpty
        ? reservedSeats.map((item) => item['seat_number'] as String).toList()
        : specialSeats;
  }

  // Hàm để lọc các ghế đã đặt bởi người dùng hiện tại
  List<String> filterMySeats(List<dynamic> arr, String myUserId) {
    // Filter seats belonging to the current user and not "reserved":
    final mySeats = arr.where((item) => item['user'] == myUserId && item['status'] != 'reserved').toList();

    // Return seat numbers of my seats:
    return mySeats.map((item) => item['seat_number'] as String).toList();
  }

  @override
  void dispose() {
    socket.disconnect(); // Ngắt kết nối khi Widget bị hủy
    super.dispose();
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
                    Image.network(
                      widget.item['movie']['imageCover'],
                      width: 105,
                      height: 180,
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
                    final seatNumber = seats[index];
                    final isSelected = selectedSeats.contains(seatNumber);

                    return GestureDetector(
                      onTap: () {
                        //handleSeatPress(seatNumber);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            seatNumber,
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
                    margin: const EdgeInsets.only(left: 50),
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
                    margin: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Image.asset(Constants.myPath),
                        const Text(
                          "My seats",
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
              Container(
                margin: const EdgeInsets.only(left: 20, top: 5),
                child: Row(
                  children: [
                    Image.asset(Constants.otherPath),
                    const Text(
                      "Other people selected seats",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: ElevatedButton(
                  onPressed: () {},
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
                          margin: const EdgeInsets.only(left: 10),
                          height: 60,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '80.000VND',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
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
