import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0.0;
  double longitude = 0.0;
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.low,
  );

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
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
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      return Future.error('Failed to check location services: $e');
    }
  }
}
