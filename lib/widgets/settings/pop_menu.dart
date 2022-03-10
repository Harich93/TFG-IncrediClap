import 'package:flutter/material.dart';
import 'package:incredibclap/screens/login_screen.dart';
import 'package:incredibclap/themes/colors.dart';

enum ActionsPopMenu { myAccount, myPlaylist, logout }


class PopMenu extends StatefulWidget {
  const PopMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<PopMenu> createState() => PopMenuState();
}

class PopMenuState extends State<PopMenu> {

  // late ActionsPopMenu _selection;

  @override
  Widget build(BuildContext context) {

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
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              )
            ]
          );
        },
      );
    }


    return PopupMenuButton<ActionsPopMenu>(
      padding: const EdgeInsets.only(right: 20),
      icon: const Icon(Icons.account_circle_outlined),
      onSelected: (ActionsPopMenu result) { 

        switch (result) {
          case ActionsPopMenu.logout:
              _showMyDialog();
            break;

          case ActionsPopMenu.myAccount:
              // TODO: Implementar ajustes de cuenta
            break;

          case ActionsPopMenu.myPlaylist:
              //TODO: Implementar playlist usuario
            break;

          default:
        }

      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ActionsPopMenu>>[
        
        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.myAccount,
          child: _PopMenuContent(
            icon: Icons.account_box_rounded,
            text: Text('Mi cuenta'),
          ),
        ),

        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.myPlaylist,
          child: _PopMenuContent(
            icon: Icons.list,
            text: Text('Mis creaciones'),
          ),
        ),

        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.logout,
          child: _PopMenuContent(
            icon: Icons.logout_outlined,
            text: Text('Cerrar sesión'),
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
    return Container(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Icon(icon, size: 18, color: ThemeColors.lightPrimary,),
          const SizedBox(width: 5),
          text
        ],
      ),
    );
  }
}