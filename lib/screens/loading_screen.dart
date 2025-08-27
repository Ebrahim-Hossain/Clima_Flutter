import 'dart:developer';

import 'package:flutter/material.dart';

import 'geo_location.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

void currentLocation() async{
  GeoLocation geoLocation = GeoLocation();
  await geoLocation.getCurrentLocation(context);

  log(geoLocation.longitude.toString());
  log(geoLocation.latitude.toString());
}


@override
  void initState() {
  currentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}