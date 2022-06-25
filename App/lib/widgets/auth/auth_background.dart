import 'package:flutter/material.dart';
import 'package:incredibclap/themes/themes.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;
  final bool icon;

  const AuthBackground({
    Key? key, 
    required this.child,
    this.icon = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _ColorBox(),
          if(icon) _UserIcon(),
          child
        ],
      ),
    );
  }
}

class _UserIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        child: const Icon( Icons.person_pin, color: Colors.white, size: 100),
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
      height: size.height * 0.4,
      decoration: _builBoxDecoration(),
    );
  }

  BoxDecoration _builBoxDecoration() =>  const BoxDecoration(
    // color: ThemeColors.primary,
    gradient: LinearGradient(
      transform: GradientRotation(11),
      colors: [
        ThemeColors.lightPrimary,
        ThemeColors.primary,
        ThemeColors.darkPrimary,
      ],
      stops: [
        0.005,
        0.3,
        0.8
      ]
    )
  );
}

