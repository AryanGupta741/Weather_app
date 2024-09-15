import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/weather/model/weather_model.dart';

class WeatherService {
  String apiKey = '8b88bedf79ad9ed696cdd2f8520b8c9f';
  String baseUrl = 'http://api.openweathermap.org/data/2.5/find';

  Future<Weather> getWeather(String city) async {
    final url = Uri.parse('${baseUrl}?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      print('error ${response.statusCode}');
      throw Exception('Failed to load weather data');
    }
  }
}
