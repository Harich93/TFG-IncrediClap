import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';

class HeaderCuadradro extends StatelessWidget {
  const HeaderCuadradro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: ThemeColors.primary
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
        color: ThemeColors.primary
      ),
    );
  }
}