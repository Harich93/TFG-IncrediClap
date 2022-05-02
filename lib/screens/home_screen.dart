
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/services/record_service.dart';
import 'package:incredibclap/widgets/shared/app_bar_custom.dart';
import 'package:incredibclap/widgets/shared/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/home/home_widgets.dart';


class HomeScreen extends StatelessWidget {

  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final menuHiden = Provider.of<MenuHidden>(context);
    final recordService = Provider.of<RecordService>(context);
    final uiProvider = Provider.of<UiProvider>(context);

    recordService.getAllAudios();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(
        title: "Incrediclap",
        elevation: menuHiden.hidden,
      ),
      body:  uiProvider.selectedMenuOpt == 0 
        ? _HomeBody()
        : const MusicScreen(),
      bottomNavigationBar: const CustomNavigationBar(),
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

    final ap = Provider.of<AudiosProvider>(context);
    final rs = Provider.of<RecordService>(context);
    
    const durationAnima = Duration(milliseconds: 500);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      controller: controller,
      child: Column( 
        children: [
      
          _TitlePage(),
        
          Center(
            child: Column(
              children: const [
          
                HomeCard( 
                  title: ' Ané Carrasco', 
                  image: AssetImage('assets/artistas/chicharito.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.play_circle, 
                  text: 'El percusionista flamenco del siglo XXI',
                ),
                  
                HomeCard( 
                  reverse: true,
                  title: 'El BO',
                  image: AssetImage('assets/artistas/bo.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.list_rounded,
                  text: 'El rey del jaleo.',
                ),
                
                HomeCard( 
                  title: 'Gregorio Fernández', 
                  image: AssetImage('assets/artistas/bo.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.play_circle, 
                  text: 'La Filarmónica de Santiago en estado puro.',
                ),
                
                HomeCard( 
                  reverse: true,
                  title: 'Chicharito',
                  image: AssetImage('assets/artistas/chicharito.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.list_rounded,
                  text: 'Ritmo con los cinco sentidos',
                ),
                
                HomeCard( 
                  title: 'Carlos Grilo', 
                  image: AssetImage('assets/artistas/chicharito.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.play_circle, 
                  text: 'El nuevo referente del soniquete jerezano',
                ),
                
                  
                HomeCard( 
                  reverse: true,
                  title: 'Luis y Ali de la Tota',
                  image: AssetImage('assets/artistas/chicharito.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.list_rounded,
                  text: 'Los gemelos palmean dos veces.',
                ),
                
                HomeCard( 
                  title: 'El Monea', 
                  image: AssetImage('assets/artistas/chicharito.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.play_circle, 
                  text: 'El pulso de los Rubichi',
                ),
                  
                HomeCard( 
                  reverse: true,
                  title: 'José Rubichi',
                  image: AssetImage('assets/artistas/chicharito.jpg'),
                  buttonColor: ThemeColors.dark, 
                  buttonIcon: Icons.list_rounded,
                  text: 'Compás por los cuatro costados',
                ),
                
              
              ],
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

    const durationAnima = Duration(milliseconds: 800);
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeColors.primary,
            Colors.white
          ],
          stops: [
            .1,
            .8
          ],
          transform: GradientRotation(71) 
        )
      ),
      padding: const EdgeInsets.symmetric( vertical: 20 ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          FadeIn(
            duration: durationAnima,
            child: const Center(
              child: Text(
                'IES Almunia',
                style:  TextStyle(
                  fontFamily: 'Amadeus',
                  // color: colorTexto,
                  fontSize: 20
                ),
              ),
            ),
          ),
          
        ]
      ),
    );
  }
}

