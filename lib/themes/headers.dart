import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';

class HeaderCuadradro extends StatelessWidget {
  
  const HeaderCuadradro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: const  BoxDecoration(
        color: ThemeColors.primary,
      ),
    );
  }
}