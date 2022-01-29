import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incredibclap/services/user_preferences_service.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/auth_service.dart';
import 'package:incredibclap/widgets/auth/auth_widgets.dart';

class RegisterScreen extends StatelessWidget {

  const RegisterScreen({Key? key}) : super(key: key);

  static const String routeName = 'Register';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              const SizedBox(height: 200),
              
              CardContainer(
                child: Column(
                  children: [

                    const SizedBox( height: 10 ),
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headline4,),
                    
                    const SizedBox( height: 30 ),
                    ChangeNotifierProvider( 
                      create: ( _ ) => LoginProvider(),
                      child: _RegisterForm(),
                    )
                    
                  ],
                ),
              ),
              const SizedBox( height: 50 ),

              const TextButtonAuth(
                text: '¿Ya tienes cuenta?', 
                ruta: LoginScreen.routeName
              ),

              const SizedBox( height: 50 ),

            ],
          ),
        )
      ),
    );
  }

}


class _RegisterForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Form(  
      key: loginProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [

          InputName(loginProvider: loginProvider),

          const SizedBox( height: 30 ),

          InputEmail(loginProvider: loginProvider),
          
          const SizedBox( height: 30 ),
          
          InputPass(loginProvider: loginProvider),

          const SizedBox( height: 30 ),

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
          

          AuthButton(
            text: 'Registrarse',
            onPressed: () async{ 

              final resp = await authService.createUser( loginProvider.name ,loginProvider.email, loginProvider.password );

              if( resp['errors'] != null ) {
                loginProvider.isError = true;
                loginProvider.textError = resp['errors']['errors'][0]['msg'];
                Timer(const Duration(seconds: 2), () => loginProvider.isError = false );
                return;
              }

              Preferences.email = resp['user']['email'];
              Preferences.name = resp['user']['name'];

              final resLog = await authService.login( loginProvider.email, loginProvider.password );

              Preferences.token = resLog['token'];

              Navigator.pushReplacementNamed(context, HomeScreen.routeName );

            },
          )

        ],
      ),
    );
  }
}