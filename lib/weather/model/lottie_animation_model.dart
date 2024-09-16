import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherLottie extends StatelessWidget {
  final String description;

  const WeatherLottie({required this.description});

  // This method maps weather descriptions to Lottie animation paths
  String _getLottieAnimationPath() {
    switch (description) {
      case 'clear sky':
        return 'assets/lottie_animation/sun_animation.json';
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
      case 'overcast clouds':
        return 'assets/lottie_animation/cloud.json';
      case 'light rain':
      case 'moderate rain':
      case 'heavy rain':
      case 'showers':
        return 'assets/lottie_animation/rain.json';
      case 'snow':
        return 'assets/lottie_animation/snow.json';
      case 'thunderstorm':
        return 'assets/lottie_animation/thunder.json';
      default:
        return 'assets/lottie_animation/sun_animation.json'; // Default to sunny
    }
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      _getLottieAnimationPath(),
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    );
  }
}
