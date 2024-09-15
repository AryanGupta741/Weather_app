import 'dart:ui';
import 'package:flutter/material.dart';

class FrostedGlassEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color to match the image
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 5; i++)
                FrostedGlassTile(
                  time: i == 1 ? 'Now' : '${12 + i} AM',
                  temperature: '19',
                  chanceOfRain: i == 0 || i == 4 ? '${30 + 20 * i}%' : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FrostedGlassTile extends StatelessWidget {
  final String time;
  final String temperature;
  final String? chanceOfRain;

  FrostedGlassTile({required this.time, required this.temperature, this.chanceOfRain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Add blur effect
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 150,  // Fixed height
              maxHeight: 150,  // Max height
              minWidth: 80,    // Fixed width
              maxWidth: 80,    // Max width
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1), // Semi-transparent white color
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
                  const SizedBox(height: 10),
                  if (chanceOfRain != null)
                    Text(
                      chanceOfRain!,
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 16,
                      ),
                    ),
                  const SizedBox(height: 10),
                  Icon(
                    Icons.cloud,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$temperature°",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


