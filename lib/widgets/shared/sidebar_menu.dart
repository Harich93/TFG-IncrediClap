import 'package:flutter/material.dart';

import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/user_preferences_service.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          
          const _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Inicio'),
            onTap: () => Navigator.pushReplacementNamed(context, HomeScreen.routeName )
          ),
          
          const Divider(),
          ListTile(
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text('Cuenta'),
            onTap: () => Navigator.pushNamed(context, AccountScreen.routeName)
          ),
          
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Ajustes'),
            onTap: () {},
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_sharp),
            title: const Text('Cerrar sesión'),
            onTap: () {
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    const textStyle = TextStyle( fontSize: 17);

    return SizedBox(
      height: 120,
      child: DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( Preferences.name , style: textStyle ),
                const Icon(Icons.account_circle ),
              ],
            ),
            Text( Preferences.email , style: textStyle )
          ]

        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(185, 226, 140, 1),
              Color.fromRGBO(115, 146, 80, 1),
            ]
          ) 
        ),
      ),
    );
  }
}