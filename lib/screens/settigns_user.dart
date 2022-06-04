import 'package:flutter/material.dart';
import 'package:incrediclap/services/services.dart';
import 'package:incrediclap/themes/colors.dart';
import 'package:incrediclap/themes/themes.dart';
import 'package:incrediclap/widgets/shared/shared.dart';

class SettingsUserScreen extends StatelessWidget {

static const String routeName = 'SettingsUser';

  const SettingsUserScreen({Key? key}) : super(key: key);
  //TODO: Settings Account
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        elevation: 0,
        title: "Ajustes de Cuenta",        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              
              const Center(
                child: Icon(
                  Icons.account_circle, 
                  color: ThemeColors.dark, 
                  size: 100
                ),
              ),

              Row(
                children: [
                  const Text(
                    "Nombre: ", 
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Amadeus'
                    )
                  ),
                  Text(Preferences.name),
                ],
              ),
              Text(Preferences.password),
              Text(Preferences.email),

            ],
          ),
        ),
      ),
    );
  }

}