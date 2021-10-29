import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ApiClient {
  static Future<Response> fetchForecasts(double lat, double lon) async {
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=' +
            lat.toString() +
            '&lon=' +
            lon.toString() +
            '&' +
            openWeatherMapApiKey +
            '&units=metric'));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("HTTP: ${response.statusCode}");
    }
  }

  static Future<Response> fetchCurrentWeather(double lat, double lon) async {
    Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=' +
            lat.toString() +
            '&lon=' +
            lon.toString() +
            '&' +
            openWeatherMapApiKey +
            '&units=metric'));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("HTTP: ${response.statusCode}");
    }
  }
}
