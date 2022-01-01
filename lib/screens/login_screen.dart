import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/services/auth_service.dart';
import 'package:incredibclap/services/user_preferences_service.dart';

import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/widgets/auth/auth_widgets.dart';


import 'package:incredibclap/screens/screens.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = 'Login';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [

                    const SizedBox( height: 10 ),
                    Text('Login', style: Theme.of(context).textTheme.headline4,),
                    
                    const SizedBox( height: 30 ),
                    ChangeNotifierProvider( 
                      create: ( _ ) => LoginProvider(),
                      child: _LoginForm(),
                    ),
                    
                  ],
                ),
              ),
              const SizedBox( height: 50 ),
              const TextButtonAuth(text: 'Crear cuenta', ruta: RegisterScreen.routeName,),
              const SizedBox( height: 50 ),
              
            ],
          ),
        )
      ),
    );
  }

}


class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Form(  
      key: loginProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          
          InputEmail(loginProvider: loginProvider),
          
          const SizedBox( height: 30),
          
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

          LoginRegisterButton(
            text: 'Ingresar',
            onPressed: () async{ 

              loginProvider.isLoading = true;

              final resp = await authService.login( loginProvider.email, loginProvider.password ); 
              
              if( resp['msg'] != null ) {
                loginProvider.isError = true;
                loginProvider.textError = resp['msg'];
                Timer(const Duration(seconds: 4), () => loginProvider.isError = false );
                loginProvider.isLoading = false;
                return;
              }

              Preferences.email = resp['user']['email'];
              Preferences.name = resp['user']['name'];
              Preferences.token = resp['token'];

              loginProvider.isLoading = false;

              Navigator.pushReplacementNamed(context, HomeScreen.routeName );
            },
          )
        
        ],
      ),
    );
  }

}

