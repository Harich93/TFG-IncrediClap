import 'package:flutter/material.dart';
import 'package:incredibclap/screens/music_screen.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/home/home_widgets.dart';

class HomeScreen extends StatelessWidget {

static const String routeName = 'Home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeBackground(child: _HomeBody())
        ],
      )
    );
  }

}

class _HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _TitlePage(),
          SizedBox(
            height: size.height * 0.8,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeCard( 
                      title: 'Crea', 
                      buttonColor: ThemeColors.darkPrimary, 
                      buttonIcon: Icons.play_circle, 
                      onPressed: () => Navigator.pushNamed(context, MusicScreen.routeName) 
                    ),

                    HomeCard( 
                      title: 'Playlist', 
                      buttonColor: ThemeColors.darkPrimary, 
                      buttonIcon: Icons.list_rounded,
                      onPressed: () => Navigator.pushNamed(context, MusicScreen.routeName) 
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard( 
                      title: 'Ajustes', 
                      buttonColor: ThemeColors.primary, 
                      buttonIcon: Icons.settings,
                      onPressed: () => Navigator.pushNamed(context, MusicScreen.routeName) 
                      
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}




class _TitlePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric( vertical: 25, horizontal: 25 ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: const [

            Text(
              'IncredibClap', 
              style: TextStyle(
                color: Colors.white, 
                fontSize: 25,
                fontWeight: FontWeight.bold
              )
            ),

            SizedBox( height: 10),
            
            SizedBox(
              width: 250,
              child: Text(
                'IES Almunia 2022',
                style:  TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

