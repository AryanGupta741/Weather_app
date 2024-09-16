// viewmodels/weather_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:testing/weather/model/weather_model.dart';
import 'package:testing/weather/weather_service/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? weather;
  bool isLoading = false;
  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeather(String city) async {
    isLoading = true;
    notifyListeners(); // Notifies the view to update the loading state

    try {
      weather = await _weatherService.getWeather(city);
    } catch (e) {
      print('Error fetching weather normal:  $e');
      weather = null;
    } finally {
      isLoading = false;
      notifyListeners(); // Notifies the view that the data has been fetched
    }
  }
}
