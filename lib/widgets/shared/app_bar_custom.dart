import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/shared/shared.dart';
import 'package:provider/provider.dart';

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
    // final AudiosProvider ap = Provider.of<AudiosProvider>(context);
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true
      ),

      title: Text(title),
      centerTitle: true,
      actions: [
        if(uiProvider.selectedMenuOpt == 0) const PopMenu()
      ],
      
      foregroundColor: Colors.black87,
      backgroundColor: ThemeColors.primary,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}