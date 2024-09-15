import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:testing/weather/view/weather_view.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  final pages = [
    WeatherView(),
    Center(child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(child: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A), // Dark blue background behind the navigation bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF0D1B2A), // Dark blue background
        color: Color(0xFF1B263B), // Dark blue for the navigation bar background
        buttonBackgroundColor: Color(0xFF415A77), // Light blue-grey for the active button
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      body: pages[_pageIndex], // Show the selected page
    );
  }
}
