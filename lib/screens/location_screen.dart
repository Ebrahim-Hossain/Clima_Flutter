import 'dart:developer';

import 'package:clima_flutter/services/weather.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.weatherData});

  final dynamic weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temp;
  String? city;
  String? weatherIcon;
  String? message;

  void uiInterface(data) {
    setState(() {
      if (data == null) {
        temp = 0;
        message = "There is something wrong";
        weatherIcon = "Error";
        city = "";
        return;
      }

      double temperature = data['main']['temp'];
      temp = temperature.toInt();
      message = weather.getMessage(temp!);
      int id = data['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(id);
      city = data['name'];
    });
  }

  @override
  void initState() {
    uiInterface(widget.weatherData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationData(context);
                      uiInterface(weatherData);
                    },
                    child: Icon(Icons.near_me, size: 50.0, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      log(typedName);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text('$temp°', style: kTempTextStyle),
                    Text(weatherIcon!, style: kConditionTextStyle),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
