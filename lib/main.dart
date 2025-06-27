import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.low,
  );
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    print('Getting location...');
    Position position = await Geolocator.getCurrentPosition();
    print('Getting location result...');
    print(position.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clime',
      theme: ThemeData.dark(),
      home: TextButton(
        onPressed: () {
          getLocation();
        },
        child: Text('Get Location'),
      ),
    );
  }
}
