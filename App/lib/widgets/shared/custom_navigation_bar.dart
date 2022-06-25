import 'package:flutter/material.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    UiProvider uiProvider = Provider.of<UiProvider>(context);
    AudiosProvider ap = Provider.of<AudiosProvider>(context);

    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: ThemeColors.primary,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home, size: 30,),
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.music_video_outlined, size: 30,),
          icon: Icon(Icons.music_video_outlined),
          label: 'Crea',
        ),
      ],
      currentIndex: uiProvider.selectedMenuOpt,
      selectedItemColor: ThemeColors.darkPrimary,
      onTap: (val) => {
        uiProvider.selectedMenuOpt = val,
        val == 0 
          ? ap.stopAll() 
          : null
      }  
    );
  }
}
