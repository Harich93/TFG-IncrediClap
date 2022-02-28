import 'package:flutter/material.dart';

enum ActionsPopMenu { harder, smarter, selfStarter, tradingCharter }


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
    return PopupMenuButton<ActionsPopMenu>(
      padding: const EdgeInsets.only(right: 20),
      icon: const Icon(Icons.account_circle_outlined),
      onSelected: (ActionsPopMenu result) {  },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<ActionsPopMenu>>[
        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.harder,
          child: Text('Working a lot harder'),
        ),
        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.smarter,
          child: Text('Being a lot smarter'),
        ),
        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.selfStarter,
          child: Text('Being a self-starter'),
        ),
        const PopupMenuItem<ActionsPopMenu>(
          value: ActionsPopMenu.tradingCharter,
          child: Text('Cerrar sesión'),
        ),
      ],
);
  }
}