
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

    recordService.getAllAudios();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(
        title: "IncrediClap",
        elevation: menuHiden.hidden,
      ),
      body:  _HomeBody(),
      bottomNavigationBar: CustomNavigationBar(),
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
          const HeaderCuadradro(),
    
          _TitlePage(),
          
          const Divider(),
          
          SizedBox(
            height: size.height * 0.73,
            child: Stack(
              children: [ 

                Center(
                  child: Column(
                    children: [
                      
                      const SizedBox(height: 40),

                      FadeIn(
                        duration: durationAnima,
                        child: HomeCard( 
                          title: 'Crea', 
                          image: const AssetImage('assets/backgrounds/backMusic.jpg'),
                          buttonColor: ThemeColors.dark, 
                          buttonIcon: Icons.play_circle, 
                          onPressed: () => {
                            ap.isMusicScreen = true,
                            Navigator.pushNamed(context, MusicScreen.routeName) 
                            
                          }
                        ),
                      ),
          

                      FadeIn(
                        duration: durationAnima,
                        child: HomeCard( 
                          title: 'Reproduce',
                          image: const AssetImage('assets/backgrounds/backMusic1.jpg'),
                          buttonColor: ThemeColors.dark, 
                          buttonIcon: Icons.list_rounded,
                          onPressed: () => {
                            rs.selectedListRecord = rs.allAudios,
                            Navigator.pushNamed(context, ListAudiosScreen.routeName) 
                          }
                        ),
                      ),

                      const SizedBox(height: 108),

                    
                    ],
                  ),
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

    const durationAnima = Duration(milliseconds: 800);
    const colorTexto = ThemeColors.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric( vertical: 25, horizontal: 25 ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          
          const SizedBox( height: 10),

          FadeIn(
            duration: durationAnima,
            child: const Center(
              child: Text(
                 'IES Almunia', 
                style: TextStyle(
                  color: colorTexto, 
                  fontFamily: 'Amadeus',
                  fontSize: 50,
                )
              ),
            ),
          ),

          const SizedBox( height: 10),
          
          FadeIn(
            duration: durationAnima,
            child: const Center(
              child: Text(
                '2021 - 2022',
                style:  TextStyle(
                  fontFamily: 'Amadeus',
                  color: colorTexto,
                  fontSize: 15
                ),
              ),
            ),
          ),

          
        ]
      ),
    );
  }
}

