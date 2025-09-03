import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
class GeoLocation {

 double? latitude;
 double? longitude;


  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.low,
    distanceFilter: 200,
  );
  Future<void> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show dialog to open app settings
      if(!context.mounted)return ;
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
      locationSettings: locationSettings,
    );
    latitude = position.latitude;
    longitude = position.longitude;
  }

}



