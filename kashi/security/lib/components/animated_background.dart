import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 10))..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: BackgroundPainter(_animation.value),
          child: Container(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BackgroundPainter extends CustomPainter {
  final double rotation;
  BackgroundPainter(this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFC49450).withOpacity(0.1);
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2.5;

    for (int i = 0; i < 6; i++) {
      double angle = (pi / 3) * i + rotation;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), radius / 3, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => true;
}
