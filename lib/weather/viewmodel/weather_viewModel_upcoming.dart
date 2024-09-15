
import 'package:flutter/foundation.dart';
import 'package:testing/weather/model/weather_model_upcoming.dart';
import 'package:testing/weather/weather_service/weather_upcoming.dart';

class WeatherViewModelUpcoming extends ChangeNotifier {
  List<WeatherUpcoming> _forecastUpcoming = [];
  final WeatherServerUpcoming _weatherServerUpcoming = WeatherServerUpcoming();
  String _cityName = 'London'; // Default city name

  List<WeatherUpcoming> get forecastUpcoming => _forecastUpcoming;

  // Method to set city name and fetch the weather
  void setCityName(String cityName) {
    _cityName = cityName;
    fetchWeatherForecast();
  }

  Future<void> fetchWeatherForecast() async {
    try {
      List<WeatherUpcoming> allForecastsUpcoming = await _weatherServerUpcoming.fetchWeatherForecast(_cityName);

      // Filter to keep only one forecast per day, for example, at noon (12:00)
      Map<String, WeatherUpcoming> dailyForecast = {};
      for (var forecast in allForecastsUpcoming) {
        String date = forecast.date;
        if (!dailyForecast.containsKey(date)) {
          dailyForecast[date] = forecast;
        }
      }

      // Update the forecast list with unique dates
      _forecastUpcoming = dailyForecast.values.toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }
}
