// lib/models/weather_model.dart

class WeatherUpcoming {
  final String date;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final String weatherDescription;
  final String icon;

  WeatherUpcoming({
    required this.date,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.weatherDescription,
    required this.icon,
  });

//The factory Weather.fromJson(Map<String, dynamic> json) is used to easily convert JSON data (from an API) into a Weather object. It simplifies the process of extracting data like temperature and description from the API response.

  factory WeatherUpcoming.fromJson(Map<String, dynamic> weatherData) {
    return WeatherUpcoming(
      date: weatherData['dt_txt'].split(' ')[0], // Extract only the date part
      temperature: weatherData['main']['temp'].toDouble(),
      minTemperature: weatherData['main']['temp_min'].toDouble(),
      maxTemperature: weatherData['main']['temp_max'].toDouble(),
      humidity: weatherData['main']['humidity'],
      weatherDescription: weatherData['weather'][0]['description'],
      icon: weatherData['weather'][0]['icon'],
    );
  }
}
