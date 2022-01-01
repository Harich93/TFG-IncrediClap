import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {

  final Widget child;

  const AuthBackground({
    Key? key, 
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _UserIcon(),
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
        margin: const EdgeInsets.only(top: 30),
        child: const Icon( Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _builBoxDecoration(),
      child: Stack(
        children: [
          Positioned( child: _Bubble(), top: 90, left: 30,),
          Positioned( child: _Bubble(), top: -40, left: -30,),
          Positioned( child: _Bubble(), top: -50, right: -20,),
          Positioned( child: _Bubble(), bottom: -50, left: 10,),
          Positioned( child: _Bubble(), bottom: 120, right: 30,),
        ],
      ),
    );
  }

  BoxDecoration _builBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(185, 226, 140, 1),
        Color.fromRGBO(115, 146, 80, 1),
      ]
    )
  );
}

class _Bubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}
