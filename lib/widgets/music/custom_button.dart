import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';

class CustomButton extends StatelessWidget {
  
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ThemeColors.dark
      ),
      child: const Center(
        child: Text('music'),
      )
    );
  }

}