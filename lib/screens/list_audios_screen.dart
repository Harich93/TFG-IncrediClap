import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:incrediclap/screens/player_screen.dart';
import 'package:incrediclap/themes/headers.dart';
import 'package:incrediclap/widgets/playlist/card_audio.dart';
import 'package:incrediclap/widgets/shared/app_bar_custom.dart';
import 'package:incrediclap/models/models.dart';

import 'package:incrediclap/screens/screens.dart';
import 'package:incrediclap/services/services.dart';
import 'package:incrediclap/themes/themes.dart';
import 'package:incrediclap/widgets/shared/shared.dart';
import 'package:incrediclap/providers/providers.dart';
import 'package:incrediclap/widgets/playlist/playlist.dart';

class ListAudiosScreen extends StatelessWidget {

static const String routeName = 'ListAudios';

  const ListAudiosScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final menuHiden = Provider.of<MenuHidden>(context);
    final isUserRecords  = Provider.of<RecordService>(context).isSelectedReordsUser;


    return Scaffold(
      appBar: AppBarCustom(
        title: isUserRecords ? "Mis creaciones" : "Todas las creaciones" ,
        elevation: menuHiden.hidden,
      ),
      body: Stack(
        children: const [
          HeaderCuadradro(),
          _ListAudios(),
        ],
      ),
    );
  }

}

class _ListAudios extends StatefulWidget {
  

  const _ListAudios({
    Key? key,
  }) : super(key: key);

  @override
  State<_ListAudios> createState() => _ListAudiosState();
}

class _ListAudiosState extends State<_ListAudios> {

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    
    final menuHiden = Provider.of<MenuHidden>(context, listen: false);

    controller.addListener(() {
      if(controller.offset <= 0) {
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
    
    final recordService  = Provider.of<RecordService>(context);
    final playerAudio  = Provider.of<PlayerAudio>(context);
    final listAudios = recordService.selectedListRecord;
    final isUserRecords = recordService.isSelectedReordsUser;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      itemCount: listAudios.length,
      itemBuilder: ( BuildContext context, int index ) => GestureDetector(
        child: CardAudio(
          id: listAudios[index].id,
          title: listAudios[index].title,
          userName: listAudios[index].userName,
          isDeleted: isUserRecords,
          onPressed: () { 
            recordService.selectedAudioRecord = listAudios[index];
            Navigator.pushNamed(context, PlayerScreen.routeName);
            playerAudio.init();
          },
        ),
      )
    );
  }
}