import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/ragistration/data_push.dart';
import 'package:testing/weather/navigation_bar.dart';
import 'package:testing/weather/viewmodel/weather_viewModel.dart';
import 'package:testing/weather/view/weather_view.dart';
import 'package:testing/weather/viewmodel/weather_viewModel_upcoming.dart';
import 'package:testing/weather/windeffect/windscreen.dart';

void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModelUpcoming()), // Provide WeatherViewModel
      ],
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      
      home: HomeScreen()
    );
  }
}