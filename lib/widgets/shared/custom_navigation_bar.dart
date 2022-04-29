import 'package:flutter/material.dart';
import 'package:incredibclap/themes/themes.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_video_outlined),
          label: 'Crea',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Playlist',
        ),
      ],
      currentIndex: 1,
      selectedItemColor: ThemeColors.primary,
      onTap: (val) => {},
    );
  }
}