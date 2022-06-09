import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/auth/auth.dart';
import 'package:incredibclap/widgets/home/background.dart';
import 'package:incredibclap/widgets/shared/shared.dart';
import 'package:provider/provider.dart';

class SettingsUserScreen extends StatelessWidget {

static const String routeName = 'SettingsUser';

  const SettingsUserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
   
    
    return Scaffold(
      appBar: const AppBarCustom(
        elevation: 0,
        title: "Ajustes de Cuenta",
        menuOpt: false,      
      ),
      body: HomeBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [

                  const Center(
                    child: Icon(
                      Icons.account_circle, 
                      color: Colors.white12, 
                      size: 110
                    ),
                  ),
              
                  ChangeNotifierProvider( 
                    create: ( _ ) => LoginProvider(),
                    child: _UserForm(),
                  )
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class _UserForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final lp = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: size.height * 0.1),
        
        CardContainer(
          child: Form(  
            key: lp.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
            
                InputName(
                  loginProvider: lp, 
                  color: ThemeColors.darkPrimary,
                  name: Preferences.name,
                ),
            
                const SizedBox( height: 30 ),
                
                InputPass(
                  loginProvider: lp, 
                  color: ThemeColors.darkPrimary,
                  label: 'Nueva contraseña',
                  placeholder: 'Contraseña...',
                  isRequired: false,
                ),

                const SizedBox( height: 30 ),

                InputPass(
                  loginProvider: lp, 
                  color: ThemeColors.darkPrimary,
                  label: 'Repite contraseña',  
                  placeholder: 'Contraseña...',  
                  confirmPass: true,
                ),
            
                const SizedBox( height: 30 ),
            
                if(lp.isError)  
                  Column(
                    children: [
                      Text(
                        lp.textError, 
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox( height: 20 ),
                    ],
                  ), 
                
            
                AuthButton(
                  text: 'Actualizar',
                  onPressed: () async{ 
            
                    lp.isLoading = true;
                    
                    final resp = await authService.updateUser( lp.name , lp.password2 );
            
                    if( resp['errors'] != null ) {
                      lp.isError = true;
                      lp.textError = resp['errors']['errors'][0]['msg'];
                      Timer(const Duration(seconds: 5), () => lp.isError = false );
                      lp.isLoading = false;
                    } 
                    else {

                      Preferences.name = resp['name'];

                      final snackBar = SnackBar(
                        content: const Text('Datos actualizados correctamente'),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {},
                        ),
                      );
            
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
            
                      lp.isLoading = false;
                    
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}