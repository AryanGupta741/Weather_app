import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:testing/weather/view/weather_view.dart';
import 'package:testing/weather/viewmodel/weather_viewModel.dart';
// import './weather_service/weather_service.dart';

class WeatherInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    final screenSize = MediaQuery.of(context).size;
    // Get the screen width and height dynamically
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
// Check if 'rain' field exists and access 1h value safely

    final double? rainui = (weatherViewModel.weather?.rain)! * 24;
    final double? windKm = (weatherViewModel.weather?.windSpeed)! * 3.6;
    return Container(
      height: screenHeight * 0.2,
      width: screenWidth * 0.9, // Adjust the width to 90% of the screen size
      padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
      decoration: BoxDecoration(
        color: Colors.deepPurple[700]!
            .withOpacity(0.5), // Semi-transparent background
        borderRadius: BorderRadius.circular(
            screenWidth * 0.05), // Responsive corner radius
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Precipitation Column
          WeatherDetailItem(
            icon: Icons.umbrella,
            label: "Precipitation",
            value: "${rainui}mm in 24hr",
            iconSize: screenWidth * 0.07, // Responsive icon size
            fontSize: screenWidth * 0.035, // Responsive font size for label
            valueFontSize: screenWidth * 0.04, // Responsive font size for value
          ),
          // Divider
          VerticalDivider(
            color: Colors.white54,
            thickness: screenWidth * 0.003, // Responsive divider thickness
            width: screenWidth * 0.05,
            indent: screenHeight * 0.01,
            endIndent: screenHeight * 0.01,
          ),
          // Wind Column
          WeatherDetailItem(
            icon: Icons.air,
            label: "Wind",
            value: "${windKm?.toStringAsFixed(1)}KM/H",
            iconSize: screenWidth * 0.07,
            fontSize: screenWidth * 0.035,
            valueFontSize: screenWidth * 0.04,
          ),
          // Divider
          VerticalDivider(
            color: Colors.white54,
            thickness: screenWidth * 0.003,
            width: screenWidth * 0.05,
            indent: screenHeight * 0.01,
            endIndent: screenHeight * 0.01,
          ),
          // Humidity Column
          WeatherDetailItem(
            icon: Icons.opacity,
            label: "Humidity",
            value: "${weatherViewModel.weather?.humidity}%",
            iconSize: screenWidth * 0.07,
            fontSize: screenWidth * 0.035,
            valueFontSize: screenWidth * 0.04,
          ),
        ],
      ),
    );
  }
}

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double iconSize;
  final double fontSize;
  final double valueFontSize;

  const WeatherDetailItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconSize,
    required this.fontSize,
    required this.valueFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: iconSize, // Dynamic icon size
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: fontSize, // Dynamic font size for the label
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: valueFontSize, // Dynamic font size for the value
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
