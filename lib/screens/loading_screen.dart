import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  void getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Permission still denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show dialog to open app settings
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Location Permission Required"),
          content: Text("You have permanently denied location permission. Please enable it in app settings."),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Open Settings"),
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openAppSettings(); // Opens system app settings
              },
            ),
          ],
        ),
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    log('Position: $position');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation(context);
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}