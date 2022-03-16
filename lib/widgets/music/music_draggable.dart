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
        height: 60,
        width: 60,
        child: Image(image: AssetImage(data.icon)),
        decoration: _buildBoxDecoration(),
      ),
      childWhenDragging: Container(
        height: 50.0,
        width: 50.0,
        decoration: _buildBoxDecoration(),
        child: Center(
          child: Image(image: AssetImage(data.icon)),
        ),
      ),
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: _buildBoxDecoration(),
        child: Center(
          child: Image(image: AssetImage(data.icon)),
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
