import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/screens/music_screen.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/widgets/home/home.dart';
import 'package:incredibclap/widgets/shared/shared.dart';


class HomeScreen extends StatelessWidget {

  static const String routeName = 'Home';
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    final ap = Provider.of<AudiosProvider>(context);
    final dm = Provider.of<DurationModel>(context);
    final uiProvider = Provider.of<UiProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        title: "",
        elevation: 0,
      ),
      body: HomeBackground(
        child: uiProvider.selectedMenuOpt == 0 
          ? _HomeBody(audios: ap.audios)
          :  const MusicScreen(),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: uiProvider.selectedMenuOpt == 1
        ? FloatingRecordButton(dm: dm)
        : null
    );
  }
}

class _HomeBody extends StatelessWidget {

  const _HomeBody({
    Key? key,
    required this.audios
  }) : super(key: key);

  final List<Audio> audios;

  @override
  Widget build(BuildContext context) {
    return Column( 
      children: [
        const TitlePage(),
        Center(
          child: CardSwiper(
            audios: audios,
          )
        )
      ]
    );
  }
}




