// ignore_for_file: must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/themes/themes.dart';

class MusicDraggable extends StatelessWidget {


  const MusicDraggable({
    Key? key, 
    required this.data,
    required this.child
  }) : super(key: key);

  final Audio data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Draggable<Audio>(
      
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
        color: ThemeColors.primary,
        borderRadius: BorderRadius.circular(50)
      );
  }
}
