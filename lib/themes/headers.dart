import 'package:flutter/material.dart';

class HeaderCuadradro extends StatelessWidget {
  const HeaderCuadradro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.green
    );
  }
}

class HeaderCircular extends StatelessWidget {
  const HeaderCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(70), bottomRight: Radius.circular(70)),
        color: Colors.green
      ),
    );
  }
}

class HeaderDiagonal extends StatelessWidget {
  const HeaderDiagonal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _DiagonalPainter(),
      ),
    );
  }
}

class _DiagonalPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    
    final paint = Paint();

    paint.color = const Color.fromRGBO(185, 226, 140, 1);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5 );
    path.lineTo(size.width, 0);
    path.lineTo(0,0);
    path.lineTo(0, size.height * 0.5 );

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class HeaderCurvo extends StatelessWidget {
  const HeaderCurvo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _CurvoPainter(),
      ),
    );
  }
}


class _CurvoPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    
    final paint = Paint();

    paint.color = const Color.fromRGBO(185, 226, 140, 1);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.20, size.width, 0);
    

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}