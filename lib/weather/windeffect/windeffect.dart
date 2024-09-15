// import 'dart:math';
// import 'package:flutter/material.dart';

// class WindEffect extends StatefulWidget {
//   @override
//   _WindEffectState createState() => _WindEffectState();
// }

// class _WindEffectState extends State<WindEffect> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 5),
//       vsync: this,
//     )..repeat(); // Continuous animation
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: WindPainter(_controller),
//       child: Container(),
//     );
//   }
// }

// class WindPainter extends CustomPainter {
//   final Animation<double> animation;
//   final Random random = Random();

//   WindPainter(this.animation) : super(repaint: animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()..color = Colors.black;
//     final double width = size.width;
//     final double height = size.height;

//     // Simulating random particles (e.g., leaves or dust)
//     for (int i = 0; i < 50; i++) {
//       final double dx = random.nextDouble() * width;
//       final double dy = random.nextDouble() * height;
//       final double windOffset = animation.value * 100;

//       canvas.drawCircle(Offset(dx + windOffset, dy), 3, paint); // Moving particles
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }



import 'package:flutter/material.dart';

class WindEffectPainter extends CustomPainter {
  final Color color;
  final double width;
  final double height;

  WindEffectPainter({
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, height / 2);

    // Adjust curve parameters as needed
    final controlPoint1 = Offset(size.width / 4, height / 4);
    final controlPoint2 = Offset(3 * size.width / 4, 3 * height / 4);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, size.width, height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RepeatingWindEffect extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final int count;

  const RepeatingWindEffect({
    Key? key,
    required this.color,
    required this.width,
    required this.height,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        count,
        (index) => Positioned(
          left: index * (width + 10), // Adjust spacing as needed
          child: CustomPaint(
            painter: WindEffectPainter(
              color: color,
              width: width,
              height: height,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RepeatingWindEffect(
          color: Colors.black,
          width: 2,
          height: 100,
          count: 5, // Adjust the number of repetitions
        ),
      ),
    );
  }
}