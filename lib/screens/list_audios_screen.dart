import 'package:flutter/material.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/widgets/playlist/playlist.dart';
import 'package:incredibclap/widgets/settings/pop_menu.dart';

class ListAudiosScreen extends StatelessWidget {

static const String routeName = 'ListAudios';

  const ListAudiosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final menuHiden = Provider.of<MenuHidden>(context);

   
    return Scaffold(
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
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      itemCount: 10,
      itemBuilder: ( BuildContext context, int index ) => GestureDetector(
        child: CardAudio(
          buttonColor: ThemeColors.primary,
          buttonIcon: Icons.ac_unit_rounded,
          onPressed: () {},
          title: "Carta de audio",
        ),
        onTap: () {
          // productsService.selectedProduct = products[index].copy();
          // Navigator.pushNamed(context, ProductScreen.routeName );
        }
      )
    );
  }
}