import 'dart:async';
import 'package:clima_flutter/screens/location_screen.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const spinkit = SpinKitCircle(color: Colors.white, size: 100.0);

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  void currentLocationData() async {

    var weatherData = await WeatherModel().getLocationData(context);


    Timer(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LocationScreen(weatherData: weatherData);
          },
        ),
      );
    });
  }

  @override
  void initState() {
    currentLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: spinkit));
  }
}

// double temp = data['main']['temp'];
// int id = data['weather'][0]['id'];
// String city = data['name'];
