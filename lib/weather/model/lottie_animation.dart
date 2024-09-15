import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  final double width;
  final double height;
  final String path;

  LottieAnimation({
    Key? key,
    required this.path,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          widget.path,
          width: widget.width,   // Dynamically using width passed to the constructor
          height: widget.height, // Dynamically using height passed to the constructor
          fit: BoxFit.fill,      // You can customize this as per your layout
        ),
      ),
    );
  }
}
