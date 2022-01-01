import 'package:flutter/material.dart';
import 'package:incredibclap/screens/create_music._screen.dart';
import 'package:incredibclap/themes/headers.dart';
import 'package:incredibclap/widgets/home/card_home.dart';
import 'package:incredibclap/widgets/shared/custom_bar.dart';
import 'package:incredibclap/widgets/shared/sidebar_menu.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home'; 

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBar(title: 'IncredibClap'),
      drawer: const SidebarMenu(),
      body: Stack(
        children: [
          const HeaderCurvo(),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox( height: 200,),
                CardHome(img: 'assets/volume.png', text: 'Crea', onPressed:() => Navigator.pushReplacementNamed(context, CreateMusicScreen.routeName) ),
                const SizedBox( height: 50,),
                CardHome( img: 'assets/playlist.png', text: 'Playlist', onPressed: (){},),
          
              ],
            ),
          ),
        ]  
      ), 
    );
  }
}

