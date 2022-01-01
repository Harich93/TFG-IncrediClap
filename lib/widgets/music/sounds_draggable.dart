// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class SoundDraggable extends StatelessWidget {


  const SoundDraggable({
    Key? key, 
    required this.data,
    required this.child
  }) : super(key: key);

  final String data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      
      data: data,
      feedback: Container(
        height: 50,
        width: 50,
        child: const Icon(Icons.directions_run),
        decoration: _buildBoxDecoration(),
      ),
      childWhenDragging: Container(
        height: 50.0,
        width: 50.0,
        decoration: _buildBoxDecoration(),
        child: const Center(
          child: Icon(Icons.send_outlined),
        ),
      ),
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: _buildBoxDecoration(),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(50)
      );
  }
}
