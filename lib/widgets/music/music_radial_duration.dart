// ignore_for_file: use_key_in_widget_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  
  final double percentage;
  final Color primaryColor;
  final Color secondColor;
  final double strokeWidthBack;
  final double strokeWidthFront;
  final StrokeCap strokeCap;
  final String percentageString;

  
  const RadialProgress({ 
    required this.percentage,
    this.primaryColor = Colors.blue,
    this.secondColor = Colors.grey,
    this.strokeWidthBack = 10,
    this.strokeWidthFront = 10,
    this.strokeCap = StrokeCap.round,
    this.percentageString = "00:00"
  });

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late double previusPercentage;

  @override
  void initState() {

    previusPercentage = widget.percentage;
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200) );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    controller.forward( from: 0.0 );
    final double differsPercentage = widget.percentage - previusPercentage;
    previusPercentage = widget.percentage;
    
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            child: Center(child: Text(widget.percentageString, style: const TextStyle(fontSize: 12, color: Colors.black87),)),
            painter: _MiRadialProgress( 
              percentage: ( widget.percentage - differsPercentage ) + ( differsPercentage * controller.value ), 
              primaryColor: widget.primaryColor,
              secondColor: widget.secondColor,
              strokeWidthBack: widget.strokeWidthBack,
              strokeWidthFront: widget.strokeWidthFront,
              strokeCap: widget.strokeCap
            ),
          ),
        );
      },
    );

  }
}


class _MiRadialProgress extends CustomPainter {

  final double percentage;
  final Color primaryColor;
  final Color secondColor;
  final double strokeWidthBack;
  final double strokeWidthFront;
  final StrokeCap strokeCap;


  _MiRadialProgress({
    required this.percentage,
    required this.primaryColor,
    required this.secondColor,
    required this.strokeWidthBack,
    required this.strokeWidthFront,
    required this.strokeCap,

  });

  @override
  void paint(Canvas canvas, Size size) {
    
    // Circulo completado
    final paint = Paint()
      ..strokeWidth = strokeWidthBack
      ..color       = secondColor
      ..style       = PaintingStyle.stroke;

    Offset center = Offset( size.width * .5, size.height * .5);
    double radius = min( size.width* .5, size.height * .5);

    canvas.drawCircle(center, radius, paint);

    // Arco
    final paintArco = Paint()
      ..strokeWidth = strokeWidthFront
      ..color       = primaryColor
      ..strokeCap   = strokeCap
      ..style       = PaintingStyle.stroke;

    // Relleno
    double arcoAngle = 2 * pi * ( percentage / 100 );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius), 
      -pi / 2, 
      arcoAngle, 
      false, 
      paintArco
    );


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}