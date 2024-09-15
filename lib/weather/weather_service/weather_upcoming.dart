
// lib/services/weatherserver.dart


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing/weather/model/weather_model_upcoming.dart';

class WeatherServerUpcoming {
  final String _apiKey = '8b88bedf79ad9ed696cdd2f8520b8c9f';  // Replace with your actual API key

  Future<List<WeatherUpcoming>> fetchWeatherForecast(String cityName) async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$_apiKey&units=metric';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dataUpcoming = jsonDecode(response.body);
      List<dynamic> forecastList = dataUpcoming['list'];
      return forecastList.map((json) => WeatherUpcoming.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load weather forecast');
    }
  }
}
