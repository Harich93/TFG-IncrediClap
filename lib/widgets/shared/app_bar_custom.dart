import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/shared/shared.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  const AppBarCustom({
    Key? key,
    required this.title,
    required this.elevation,
  }) : super(key: key);

  final double elevation;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(

      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true
      ),

      title: Text(title),
      centerTitle: true,
      actions: const [
        PopMenu()
      ],
      
      foregroundColor: Colors.black87,
      backgroundColor: ThemeColors.primary,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}