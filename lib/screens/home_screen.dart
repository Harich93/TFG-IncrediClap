import 'package:flutter/material.dart';
import 'package:incredibclap/widgets/settings/pop_menu.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/music_screen.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/home/home_widgets.dart';


class HomeScreen extends StatelessWidget {

  static const String routeName = 'Home';

  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    
    final menuHiden = Provider.of<MenuHidden>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("IncredibClap"),
        centerTitle: true,
        actions: const [
          PopMenu()
        ],
        foregroundColor: Colors.black87,
        backgroundColor: ThemeColors.primary,
        elevation: menuHiden.hidden,
      ),
      body:  _HomeBody()
    );
  }

}



class _HomeBody extends StatefulWidget {

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
    
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    
    final menuHiden = Provider.of<MenuHidden>(context, listen: false);

    controller.addListener(() {
      if(controller.offset == 0) {
        menuHiden.hidden = 0;
      } else if(controller.offset < 10) {
        menuHiden.hidden = 2;
      } else {
        menuHiden.hidden = 5;
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      controller: controller,
      child: Column( 
        children: [
          const HeaderCuadradro(),

          _TitlePage(),
          
          const Divider(),
          
          SizedBox(
            height: size.height * 0.72,
            child: Stack(
              children: [ 

                Column(
                  children: [
                    
                    const SizedBox(height: 50),

                    HomeCard( 
                      title: 'Crea', 
                      image: const AssetImage('assets/backgrounds/backMusic.jpg'),
                      buttonColor: ThemeColors.dark, 
                      buttonIcon: Icons.play_circle, 
                      onPressed: () => Navigator.pushNamed(context, MusicScreen.routeName) 
                    ),
          

                    HomeCard( 
                      title: 'Playlist',
                      image: const AssetImage('assets/backgrounds/backMusic1.jpg'),
                      buttonColor: ThemeColors.dark, 
                      buttonIcon: Icons.list_rounded,
                      onPressed: () => Navigator.pushNamed(context, MusicScreen.routeName) 
                    ),

                    const SizedBox(height: 150),

                    Column(
                      children: const [
                        Center(
                          child: Text(
                            'Creado por Benito Lopez-Cepero Martin',
                            style:  TextStyle(
                              fontFamily: 'Amadeus',
                              color: ThemeColors.dark,
                              fontSize: 15
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]

            ),
          ),
        ],
      ),
    );
  }
}




class _TitlePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    const colorTexto = ThemeColors.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric( vertical: 25, horizontal: 25 ),
      width: double.infinity,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: const [
            SizedBox( height: 10),

            Center(
              child: Text(
                 'IES Almunia', 
                style: TextStyle(
                  color: colorTexto, 
                  fontFamily: 'Amadeus',
                  fontSize: 50,
                )
              ),
            ),

            SizedBox( height: 10),
            
            Center(
              child: Text(
                '2021 - 2022',
                style:  TextStyle(
                  fontFamily: 'Amadeus',
                  color: colorTexto,
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

