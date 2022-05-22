import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';


class HomeBackground extends StatelessWidget {

  final Widget child;

  const HomeBackground({
    Key? key, 
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _ColorBox(),
          child
        ],
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      decoration: _builBoxDecoration(),
    );
  }

  BoxDecoration _builBoxDecoration() => const BoxDecoration(
    gradient: RadialGradient(
      colors: [
        Colors.white,
        ThemeColors.primary,
      ],
      radius: .6
    )
  );
}

