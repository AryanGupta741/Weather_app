class Weather {
  late final double temperature;
  late final String description;
  late final int humidity;
  late final double windSpeed;
  late final double rain;

  Weather(
      {required this.temperature,
      required this.description,
      required this.windSpeed,
      required this.humidity,
      required this.rain});
//The factory Weather.fromJson(Map<String, dynamic> json) is used to easily convert JSON data (from an API) into a Weather object. It simplifies the process of extracting data like temperature and description from the API response.
  factory Weather.fromJson(Map<String, dynamic> weatherData) {
    return Weather(
      temperature: weatherData['list'][0]['main']['temp'],
      description: weatherData['list'][0]['weather'][0]['description'],
      humidity: weatherData['list'][0]['main']['humidity'],
      windSpeed: weatherData['list'][0]['wind']['speed'],
      rain: weatherData['list'][0]['rain'] != null ? weatherData['list'][0]['rain']['1h'] : 0.0,
      
    );
  }
}
