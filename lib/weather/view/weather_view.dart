import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:testing/weather/model/lottie_animation_model.dart';
import 'package:testing/weather/ui.dart';
import 'package:testing/weather/viewmodel/weather_viewModel.dart';
import 'package:testing/weather/viewmodel/weather_viewModel_upcoming.dart';
import '../weather_service/weather_service.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherService weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    final screenSize = MediaQuery.of(context).size;
    final viewModel = Provider.of<WeatherViewModelUpcoming>(context);
    String _weatherDescription = "";
    
    @override
    void initState() {
      super.initState();
      _weatherDescription = weatherViewModel.weather!.description;
      print('${_weatherDescription.toString()}');
    }

    return Scaffold(
      body: weatherViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weatherViewModel.weather != null
              ? Stack(
                  children: [
                    // Background Image
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Frosted Glass Effect for the background
                    BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 5, sigmaY: 5), // Blur for frosted effect
                      child: Container(
                        color: Colors.black
                            .withOpacity(0.2), // Dark overlay for night effect
                      ),
                    ),

                    // Main Content
                    Padding(
                      padding: EdgeInsets.all(
                          screenSize.width * 0.04), // Responsive padding
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            // Search Bar
                            SizedBox(
                              width:
                                  screenSize.width * 0.92, // Responsive width
                              child: TextField(
                                controller: _searchController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Search city...',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.5),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: screenSize.height * 0.02),
                                ),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    weatherViewModel.fetchWeather(value);
                                    viewModel.setCityName(value);
                                  }
                                },
                              ),
                            ),

                            // const SizedBox(height: 20),

                            // Weather Info and Lottie Animation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Lottie Animation
                                SizedBox(
                                    width: screenSize.width *
                                        0.4, // Responsive width
                                    height: screenSize.width *
                                        0.4, // Maintain aspect ratio
                                    child: WeatherLottie(
                                        description:
                                            '${weatherViewModel.weather?.description}')

                                    // Lottie.asset(
                                    //   'assets/lottie_animation/sun_animation.json',
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),

                                // Weather Info Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Temperature: ${weatherViewModel.weather?.temperature} °C',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Text(
                                        'Description: ${weatherViewModel.weather?.description}',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            WeatherInfoRow(),
                            const SizedBox(height: 30),
                            // Frosted Glass Tiles for upcoming weather forecast
                            Center(
                              child: SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: viewModel.forecastUpcoming.length,
                                  itemBuilder: (context, index) {
                                    final weather =
                                        viewModel.forecastUpcoming[index];
                                    return FrostedGlassTile(
                                        time: '${weather.date}'.substring(8),
                                        temperature: '${weather.temperature}°C',
                                        chanceOfRain: '${weather.humidity}%',
                                        networkImage:
                                            'http://openweathermap.org/img/w/${weather.icon}.png');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        viewModel.setCityName(_searchController.text.isNotEmpty
                            ? _searchController.text
                            : 'Dabra');
                        weatherViewModel.fetchWeather(
                            _searchController.text.isNotEmpty
                                ? _searchController.text
                                : 'Dabra');
                      });
                    },
                    child: const Text('Get Weather'),
                  ),
                ),
    );
  }
}

class FrostedGlassTile extends StatelessWidget {
  final String time;
  final String temperature;
  final String? chanceOfRain;
  final String networkImage; // Added network image parameter

  FrostedGlassTile(
      {required this.time,
      required this.temperature,
      required this.chanceOfRain,
      required this.networkImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            height: 150,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                if (chanceOfRain != null)
                  Text(
                    chanceOfRain!,
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                    ),
                  ),
                const SizedBox(height: 5),
                // Display the network image
                Image.network(
                  networkImage, // Use the network image here
                  height: 30,
                  width: 30,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 50,
                  ), // Fallback in case of image loading error
                ),
                const SizedBox(height: 5),
                Text(
                  "$temperature°",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
