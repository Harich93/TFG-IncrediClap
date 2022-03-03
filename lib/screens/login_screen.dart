import 'dart:async';
import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:provider/provider.dart';

import 'package:incredibclap/services/services.dart';

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
          
          InputEmail(
            loginProvider: loginProvider,
            email: Preferences.recordUser ? Preferences.email : '',
          ),
          
          const SizedBox( height: 30),
          
          InputPass(
            loginProvider: loginProvider,
            pass: Preferences.recordUser ? Preferences.password : '',
          
          ),

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
            text: 'Ingresar',
            onPressed: () async{ 

              loginProvider.isLoading = true;

              final resp = await authService.login( loginProvider.email, loginProvider.password ); 
              
              if( !_isError(loginProvider, resp) ) {
                _recorUser(loginProvider);
                _savePreferncesResp(resp);
                Navigator.pushReplacementNamed(context, HomeScreen.routeName );
              }

              loginProvider.isLoading = false;

            },
          ),

          const SizedBox(height: 15),

          const _RecordMe(),
        
        ],
      ),
    );
  }

  bool _isError( LoginProvider loginProvider, Map<String,dynamic> resp ) {
    
    if( resp['msg'] != null ) {
      loginProvider.isError = true;
      loginProvider.textError = resp['msg'];
      Timer(const Duration(seconds: 4), () => loginProvider.isError = false );
      loginProvider.isLoading = false;
      return true;
    }

    return false;
  }

  _savePreferncesResp( Map<String,dynamic> resp ){
    
    Preferences.email = resp['user']['email'];
    Preferences.name = resp['user']['name'];
    Preferences.token = resp['token'];
    
  }

  _recorUser( LoginProvider loginProvider ) {
    if( Preferences.recordUser ){
      Preferences.email = loginProvider.email;
      Preferences.password = loginProvider.password;
    }
  }


}

class _RecordMe extends StatefulWidget {
  const _RecordMe({Key? key}) : super(key: key);

  @override
  State<_RecordMe> createState() => _RecordMeState();
}

class _RecordMeState extends State<_RecordMe> {
  bool isChecked = Preferences.recordUser;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return ThemeColors.dark;
      }
      return ThemeColors.primary;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Recordar usuario"),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              Preferences.recordUser = isChecked;
            });
          },
        ),


      ],
    );
  }
}


