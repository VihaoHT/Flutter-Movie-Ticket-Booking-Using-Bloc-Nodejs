import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/auth/screens/login_screen.dart';
import 'package:movie_booking_app/core/constants/constants.dart';

class CinemaScreen extends StatelessWidget {
  final String id;
  final String title;

  const CinemaScreen({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> fetchData() async {
      final response = await get(Uri.parse("$uri/api/showtimes?title=$title"));

      if (response.statusCode == 200) {
        // Nếu kết quả thành công, giải mã JSON và trả về danh sách dữ liệu
        return json.decode(response.body)['data'];
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
                GestureDetector(
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
                    "Choose Cinema",
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
                  return const Center(child: CircularProgressIndicator()); // Hiển thị indicator khi đang tải dữ liệu
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         LoginScreen(),
                      //   ),
                      // );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Container(
                        color: const Color(0xff201934),
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var item = snapshot.data?[index];
                            var cinemaName = item['room']['cinema']['name'];
                            var cinemaAddress =
                                item['room']['cinema']['location']['address'];
                            //  print(item['room']['cinema']['location']['coordinates']);
                            return Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20, top: 5),
                                  child: Column(
                                    children: [
                                      Image.asset(Constants.locationPath),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "12km",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: Text(
                                        cinemaName,
                                        style: const TextStyle(
                                          color: Constants.colorTitle,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: 300,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        cinemaAddress,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Image.asset(Constants.linePath),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
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
