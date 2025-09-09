import 'package:flutter/cupertino.dart';
import '../screens/geo_location.dart';
import 'networking.dart';

const String apiKey = 'ec7e7f457581d84099b4738d08e5d1cf';

class WeatherModel {

  Future<void> getCityData(BuildContext context,String cityName) async {
    GetWeatherData getWeatherData = GetWeatherData(
      url:
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
    );
    var weatherData = await getWeatherData.getData();
    return weatherData;

  }

  Future<dynamic> getLocationData(BuildContext context) async {

    GeoLocation geoLocation = GeoLocation();
    await geoLocation.getCurrentLocation(context);

    GetWeatherData getWeatherData = GetWeatherData(
      url:
      'https://api.openweathermap.org/data/2.5/weather?lat=${geoLocation.latitude}&lon=${geoLocation.longitude}&appid=$apiKey&units=metric',
    );
    var weatherData = await getWeatherData.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}