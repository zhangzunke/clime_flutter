import 'package:clime_flutter/screens/location_screen.dart';
import 'package:clime_flutter/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clime_flutter/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String apiKey = '38db17e7b8522dbf6617a0769e78a48f';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({super.key});
  @override
  State<Loadingscreen> createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {
  @override
  void initState() {
    print('initState');
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getLocation();
    final String api =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(api);
    var weatherData = await networkHelper.getData();
    if (!mounted) return;
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(weatherData: weatherData);
        },
      ),
    );
    if (result == true) {
      print("Back to home page");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 100.0),
      ),
    );
  }
}
