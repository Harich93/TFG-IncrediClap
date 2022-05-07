
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/services/record_service.dart';
import 'package:incredibclap/widgets/home/home_card_swiper.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: uiProvider.selectedMenuOpt == 1 
        ? FloatingActionButton(
          onPressed: (){},
          mini: true,
          backgroundColor: ThemeColors.primary,
          child: const Icon(Icons.radio_button_checked_rounded, color: Colors.black87,),
        )
        : null
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
    // final rs = Provider.of<RecordService>(context);
    
    // const durationAnima = Duration(milliseconds: 500);
    // Size size = MediaQuery.of(context).size;

    return Column( 
      children: [
    
        _TitlePage(),
      
        Center(
          child: CardSwiper(audios: ap.audios)
        )
      ]
    );
  }
}

class _TitlePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    const durationAnima = Duration(milliseconds: 800);
    
    return Container(
      padding: const EdgeInsets.symmetric( vertical: 20 ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Icon(Icons.library_music_sharp, size: 100,),
          FadeIn(
            duration: durationAnima,
            child: const Center(
              child: Text(
                'IncrediClap',
                style: TextStyle(
                  fontFamily: 'Amadeus',
                  // color: colorTexto,
                  fontSize: 60
                ),
              ),
            ),
          ),
          
        ]
      ),
    );
  }
}

