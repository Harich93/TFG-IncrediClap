import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/colors.dart';

enum ActionsPopMenu { myAccount, myPlaylist, allPlaylist, logout }


class PopMenu extends StatefulWidget {
  const PopMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<PopMenu> createState() => PopMenuState();
}

class PopMenuState extends State<PopMenu> {

  @override
  Widget build(BuildContext context) {

    final rs = Provider.of<RecordService>(context);
    final ap = Provider.of<AudiosProvider>(context);
    const textStile = TextStyle(color: ThemeColors.primary);
    
    Future<void> _showMyDialog() async { 
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cerrar sesión'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('¿Desea salir de la aplicacíon?'),
                ],
              ),
            ),
            actions: <Widget>[
              
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  ap.isMusicScreen == true ? ap.stopAll() : null;
                  ap.isMusicScreen = false;
                  SystemNavigator.pop();
                },
              )
            ]
          );
        },
      );
    }

    return PopupMenuButton<ActionsPopMenu>(
      padding: const EdgeInsets.only(right: 40),
      icon: const Icon(Icons.menu, color: ThemeColors.darkPrimary, size: 30,),
      color: ThemeColors.darkPrimary,
      onSelected: (ActionsPopMenu result) { 

        switch (result) {
          case ActionsPopMenu.logout:
              _showMyDialog();
              ap.isMusicScreen = false;
            break;

          case ActionsPopMenu.myAccount:
              Navigator.pushNamed(context, SettignsUserScreen.routeName);
            break;

          case ActionsPopMenu.myPlaylist:
              ap.isMusicScreen == true ? ap.stopAll() : null;
              rs.isSelectedReordsUser = true;
              rs.getAudiosUser();
              rs.selectedListRecord = rs.userAudios;
              Navigator.push(context ,MaterialPageRoute(builder: (context) => const ListAudiosScreen()));
              ap.isMusicScreen == false;
            break;

          case ActionsPopMenu.allPlaylist:
              ap.isMusicScreen == true ? ap.stopAll() : null;
              rs.isSelectedReordsUser = false;
              rs.getAllAudios();
              rs.selectedListRecord = rs.allAudios;
              Navigator.push(context ,MaterialPageRoute(builder: (context) => const ListAudiosScreen()));
              ap.isMusicScreen == false;
            break;

          default:
        }

      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ActionsPopMenu>>[
        
        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.myAccount,
          child: _PopMenuContent(
            icon: Icons.account_box_rounded,
            text: Text('Mi cuenta', style: textStile),
          ),
        ),

        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.myPlaylist,
          child: _PopMenuContent(
            icon: Icons.queue_music_rounded,
            text: Text('Mis creaciones', style: textStile),
          ),
        ),

        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.allPlaylist,
          child: _PopMenuContent(
            icon: Icons.queue_music_outlined,
            text: Text('Todas las Creaciones', style: textStile),
          ),
        ),

        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.logout,
          child: _PopMenuContent(
            icon: Icons.logout_outlined,
            text: Text('Cerrar sesión', style: textStile),
          ),
        ),
      ],
);
  }
}

class _PopMenuContent extends StatelessWidget {
  const _PopMenuContent({
    Key? key, required this.icon, required this.text,
  }) : super(key: key);

  final IconData icon;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ThemeColors.primary),
        const SizedBox(width: 5),
        text
      ],
    );
  }
}