import 'dart:developer';

import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key,this.onBack});

  final Function(String?)? onBack;

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
              Container(padding: EdgeInsets.all(20.0), child: null),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    cityName = value;
                    log(value);

                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  if(cityName != null) {
                    widget.onBack!(cityName);
                  }
                  Navigator.pop(context);
                },
                child: Text('Get Weather', style: kButtonTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
