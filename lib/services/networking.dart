import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class GetWeatherData {
  GetWeatherData({required this.url});

 final String url;
  Future getData() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    }else {
      log('${response.statusCode}');
      log(response.body);
    }
  }


}