import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incredibclap/models/user_model.dart';
import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/auth_service.dart';
import 'package:incredibclap/services/user_preferences_service.dart';
import 'package:incredibclap/themes/headers.dart';
import 'package:incredibclap/widgets/auth/auth_widgets.dart';
import 'package:incredibclap/widgets/shared/custom_bar.dart';
import 'package:incredibclap/widgets/shared/sidebar_menu.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {

static const String routeName = 'Account';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBar( title: 'Cuenta',),
      drawer: const SidebarMenu(),
      body: Stack(
        
        children: [

          const HeaderCurvo(),
          
          Padding(
            padding: const EdgeInsets.only( left: 130),
            child: TextButton.icon(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.red[400]),
                  visualDensity: VisualDensity.compact
                ),
                onPressed: (){}, 
                icon: Icon(Icons.delete, color: Colors.red[300] ), 
                label: Text(
                  'Eliminar cuenta', 
                  style: TextStyle( 
                    color: Colors.red[300], 
                    fontWeight: FontWeight.bold,
                    fontSize: 15   
                  ),
                )
              ),
            
          ),

          Padding(
            padding: const EdgeInsets.symmetric( vertical: 20),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),

                  CardContainer(
                    child: ChangeNotifierProvider(
                      create: ( _ ) => LoginProvider(),  
                      child: const _Form()
                    ),
                  ),

                ]
              ),
            ),
          ),
          
          

        ],  
      ),
    );
       
  }

}

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Form(  
      key: loginProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [

          Text('Datos', style: Theme.of(context).textTheme.headline4,),
          
          const SizedBox( height: 20 ),
                    
          InputName(loginProvider: loginProvider, name: Preferences.name ),

          const SizedBox( height: 20 ),

          InputEmail(loginProvider: loginProvider, email: Preferences.email ),
          
          const SizedBox( height: 20 ),
          
          InputPass(loginProvider: loginProvider),

          const SizedBox( height: 20 ),

          if(loginProvider.isError)  
            Column(
              children: [
                Text(
                  loginProvider.textError, 
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox( height: 20 ),
              ],
            ), 
          

          LoginRegisterButton(
            text: 'Modificar datos',
            onPressed: () async{ 

              final resp = await authService.createUser( loginProvider.name ,loginProvider.email, loginProvider.password );

              if( resp['errors'] != null ) {
                loginProvider.isError = true;
                loginProvider.textError = resp['errors']['errors'][0]['msg'];
                Timer(const Duration(seconds: 2), () => loginProvider.isError = false );
                return;
              }

              loginProvider.connectedUser = User(
                email: loginProvider.email,
                name: loginProvider.name
              );

              Navigator.pushReplacementNamed(context, HomeScreen.routeName );

            },
          )

        ],
      ),
    );
  }
}
