import 'package:flutter/material.dart';
import 'package:get/get.dart' as Getx;
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/constants/constants.dart';

class DetailMyTicketScreen extends StatelessWidget {
  final Map<String, dynamic> ticketItem;

  const DetailMyTicketScreen({super.key, required this.ticketItem});

  @override
  Widget build(BuildContext context) {
    var date = ticketItem['showtime']['start_time'];

    //format Date
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        DateFormat('EEEE dd-MM-yyyy', 'vi_VN').format(dateTime);

    //format Time
    DateTime dateTime2 = DateTime.parse(date);
    String formattedTime = DateFormat.jm('vi_VN').format(dateTime);

    var cost = ticketItem['showtime']['price'];
    // total Cost of ticket
    var totalCost = cost * ticketItem['seats'].length;

    //format total Cost (im in Viet Nam so i use vi_VN )
    String formattedCost =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(totalCost);

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
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  child: const Text(
                    "Detail Ticket",
                    style: TextStyle(
                      color: Constants.colorTitle,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 29, top: 20),
                  child: InkWell(
                    onTap: () {
                      Getx.Get.defaultDialog(
                        title: "INFORMATION!",
                        titleStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        middleText: "Scan The QR Code For Ticket Code",
                        middleTextStyle: const TextStyle(
                            color: Constants.colorTitle,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      );
                    },
                    child: Image.asset(Constants.informationPath),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff637394),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: QrImageView(
                        data: ticketItem['ticket_code'],
                        version: QrVersions.auto,
                        size: 240.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(Constants.tearLinePath),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Text(
                      ticketItem['showtime']['movie']['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                'Cinema: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                ticketItem['showtime']['room']['cinema']
                                    ['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          margin: const EdgeInsets.only(left: 60),
                          child: Text(
                            ticketItem['showtime']['room']['cinema']['location']
                                ['address'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                'Date: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "$formattedDate, $formattedTime",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                'Room: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                ticketItem['showtime']['room']['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                'Seats: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                ticketItem['seats'].join(", "),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Text(
                                'Cost: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                formattedCost,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
