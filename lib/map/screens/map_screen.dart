import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as Lottie;
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:movie_booking_app/map/widgets/custom_text_field_map.dart';
import 'package:url_launcher/url_launcher.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation;
  List<Marker> markers = [];
  int selectedMarkerIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    fetchCinema();
  }

  void openGoogleMaps(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Cannot launch Google Maps');
    }
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

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Locationn denied");
      permission = await Geolocator.requestPermission();
    }
    Position currenPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _currentLocation =
          LatLng(currenPosition.latitude, currenPosition.longitude);
    });
  }

  Future<List<dynamic>> fetchCinema() async {
    final response = await get(Uri.parse("$uri/api/cinemas"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> cinemaDataMap = json.decode(response.body);
      final List<dynamic> cinemas = cinemaDataMap['data']['data'];

      for (var index = 0; index < cinemas.length; index++) {
        final LatLng coordinates = LatLng(
          cinemas[index]['location']['coordinates'][1],
          cinemas[index]['location']['coordinates'][0],
        );

        markers.add(
          Marker(
            width: 500.0,
            height: 500.0,
            point: coordinates,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedMarkerIndex = index;
                });

                _showDialogCinema(index, cinemas);
              },
              child: Lottie.LottieBuilder.asset(
                Constants.cinemamarkerAnimation,
              ),
            ),
          ),
        );
      }

      return cinemas;
    } else {
      throw Exception('Failed to load data');
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Container(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: _currentLocation!,
                    initialZoom: 18,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 500.0,
                          height: 500.0,
                          point: _currentLocation!,
                          child: InkWell(
                            onTap: () {
                              print("Your current location");
                            },
                            child: Lottie.LottieBuilder.asset(
                              Constants.userMarkerAnimation,
                            ),
                          ),
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: InkWell(
                                onTap: () {
                                  
                                },
                                child: Image.asset(Constants.searchPath))),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CustomTextFieldMap(
                              controller: searchController,
                              hintText: "",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _showDialogCinema(int index, List<dynamic> cinemas) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: fetchCinema(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print((snapshot.error.toString()));
              return Center(child: Text(snapshot.error.toString()));
            }
            return SimpleDialog(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Cinema Name: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Constants.colorTitle,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: (snapshot.data![selectedMarkerIndex]
                          ['name']),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Constants.colorTitle,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Cinema Address: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Constants.colorTitle,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: (snapshot.data![selectedMarkerIndex]
                          ['location']['address']),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Constants.colorTitle,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                  future: fetchDistances(
                      snapshot.data![selectedMarkerIndex]['_id']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                          child: Column(
                            children: [
                              Text(
                                "Distance is loading... pls wait",
                                style: TextStyle(
                                    color: Constants.colorTitle,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircularProgressIndicator(),
                            ],
                          ));
                    } else if (snapshot.hasError) {
                      print((snapshot.error.toString()));
                      return Center(
                          child: Text(snapshot.error.toString()));
                    }
                    var distanceData = snapshot.data?[index];
                    var distance = distanceData['distance'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Distance: ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Constants.colorTitle,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "$distance km",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Constants.colorTitle,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        openGoogleMaps(
                            cinemas[index]['location']
                            ['coordinates'][1],
                            cinemas[index]['location']
                            ['coordinates'][0]);
                      },
                      child: const Text(
                        "Click here to see correct way to go cinema",
                        style: TextStyle(
                            color: Constants.colorTitle,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 2,
                            fontWeight: FontWeight.w700),
                      ),
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
