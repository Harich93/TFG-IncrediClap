import 'package:flutter/material.dart';
import 'package:incredibclap/services/user_preferences_service.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/shared/app_bar_custom.dart';

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