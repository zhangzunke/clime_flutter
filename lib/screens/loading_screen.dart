import 'package:clime_flutter/screens/location_screen.dart';
import 'package:clime_flutter/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    var weatherData = await WeatherModel().getLocationWeather();
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
