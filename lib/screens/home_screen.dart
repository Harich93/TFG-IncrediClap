import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/home/home.dart';
import 'package:incredibclap/widgets/music/music.dart';
import 'package:incredibclap/widgets/shared/shared.dart';


class HomeScreen extends StatelessWidget {

  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final menuHiden = Provider.of<MenuHidden>(context);
    final rs = Provider.of<RecordService>(context);
    final dm = Provider.of<DurationModel>(context);
    final uiProvider = Provider.of<UiProvider>(context);

    rs.getAllAudios();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(
        title: "",
        elevation: menuHiden.hidden,
      ),
      body: HomeBackground(
        child: uiProvider.selectedMenuOpt == 0 
          ? _HomeBody()
          : const MusicScreen(),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: uiProvider.selectedMenuOpt == 1 
        ? FloatingActionButton(
          onPressed: (){},
          // mini: true,
          backgroundColor: ThemeColors.darkPrimary,
          child: Stack(
            children: [
              RadialProgress(
                primaryColor: rs.isRecord ? Colors.red : ThemeColors.primary ,
                secondColor: ThemeColors.primary,
                percentage: dm.porcentaje,
                percentageString: dm.currentSecond,
                strokeWidthBack: 5,
                strokeWidthFront: 5,
              ),
              // const Icon(Icons.radio_button_checked_rounded, color: Colors.black87)

            ]
          ),
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
        const TitlePage(),
        Center(
          child: CardSwiper(audios: ap.audios)
        )
      ]
    );
  }
}



