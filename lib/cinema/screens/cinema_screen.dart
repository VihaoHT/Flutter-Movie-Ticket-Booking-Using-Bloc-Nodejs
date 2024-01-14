import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/showtime/screens/showtime_screen.dart';
import 'package:get/get.dart' as Getx;

class CinemaScreen extends StatefulWidget {
  final String id;
  final String title;

  const CinemaScreen({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  State<CinemaScreen> createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  @override
  void initState() {
    super.initState();
    fetchDistances("");
  }
  Future<List<dynamic>> fetchDistances(String cinemaId) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      //print("Locationn denied");
      permission = await Geolocator.requestPermission();
    }
    Position currenPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    //print("Latitude=${currenPosition.latitude.toString()}");
    // print("Longtitude=${currenPosition.longitude.toString()}");

    final response = await get(Uri.parse(
        '$uri/api/cinemas/distances/${currenPosition.latitude.toString()}, ${currenPosition.longitude.toString()}'));

    if (response.statusCode == 200) {
      //print(json.decode(response.body)['data']['distances']);
      return json.decode(response.body)['data']['distances'];
    } else {
      throw Exception('Failed to load distances');
    }
  }

  Future<List<dynamic>> fetchData() async {
    final response = await get(Uri.parse("$uri/api/showtimes?title=${widget.title}"));

    if (response.statusCode == 200) {
      // print( json.decode(response.body)['data']);
      return json.decode(response.body)['data'];
    } else {
      // Nếu không thành công, ném một ngoại lệ
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {


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
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Display loading for data waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data?[index];
                        var cinemaName = item['room']['cinema']['name'];
                        var cinemaAddress =
                            item['room']['cinema']['location']['address'];
                        //  print(item['room']['cinema']['location']['coordinates']);
                        return FutureBuilder(
                            future:
                                fetchDistances(item['room']['cinema']['_id']),
                            builder: (context, distanceSnapshot) {
                              if (distanceSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child:
                                        CircularProgressIndicator()); // Display loading for data waiting
                              } else if (distanceSnapshot.hasError) {
                                return Text('Error: ${distanceSnapshot.error}');
                              } else {
                                var distanceData =
                                    distanceSnapshot.data?[index];
                                var distance = distanceData['distance'];
                                //print(distance);
                                return InkWell(
                                  onTap: () {
                                    Getx.Get.to(
                                        ShowTimeScreen(
                                          id: item['room']['cinema']['_id'],
                                          title: item['movie']['title'],
                                        ),
                                        transition: Getx.Transition.fade,
                                        duration:
                                            const Duration(milliseconds: 1000));
                                  },
                                  child: Container(
                                    color: const Color(0xff201934),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, top: 5),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  Constants.locationPath),
                                              const SizedBox(height: 5),
                                              Text(
                                                "$distance km",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
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
                                              margin: const EdgeInsets.only(
                                                  left: 20),
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
                                    ),
                                  ),
                                );
                              }
                            });
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
