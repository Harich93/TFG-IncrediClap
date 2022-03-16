import 'package:flutter/material.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/record_service.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/shared/app_bar_custom.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/widgets/playlist/playlist.dart';

class ListAudiosScreen extends StatelessWidget {

static const String routeName = 'ListAudios';

  const ListAudiosScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final menuHiden = Provider.of<MenuHidden>(context);

    return Scaffold(
      appBar: AppBarCustom(
        title: "IncrediClap",
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
    final listAudios = recordService.selectedListRecord;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      itemCount: listAudios.length,
      itemBuilder: ( BuildContext context, int index ) => GestureDetector(
        child: CardAudio(
          title: listAudios[index].title,
          userName: listAudios[index].userName,
          onPressed: () { 
            Provider(create: (_) => AudiosProviderPlayer());
            recordService.selectedAudioRecord = listAudios[index];
            Navigator.pushNamed(context, PlayerScreen.routeName);
          },
        ),
      )
    );
  }
}