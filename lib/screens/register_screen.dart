import 'dart:async';
import 'package:flutter/material.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/widgets/auth/auth.dart';

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
                      child: _RegisterForm(ThemeColors.primary),
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

// ignore: must_be_immutable
class _RegisterForm extends StatelessWidget {
  
  _RegisterForm(this.color);
  Color color;
  
  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Form(  
      key: loginProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [

          InputName(loginProvider: loginProvider, color: color,),

          const SizedBox( height: 30 ),

          InputEmail(loginProvider: loginProvider, color: color,),
          
          const SizedBox( height: 30 ),
          
          InputPass(loginProvider: loginProvider, color: color),

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
            text: 'Registrar',
            onPressed: () async{ 

              loginProvider.isLoading = true;

              final resp = await authService.createUser( loginProvider.name ,loginProvider.email, loginProvider.password );

              if( resp['errors'] != null ) {
                loginProvider.isError = true;
                loginProvider.textError = resp['errors']['errors'][0]['msg'];
                Timer(const Duration(seconds: 5), () => loginProvider.isError = false );
                loginProvider.isLoading = false;
              } 
              else { // Login
              
                final snackBar = SnackBar(
                  content: const Text('Compruebe su correo para verificar su cuenta'),
                  action: SnackBarAction(
                    label: 'Ir a login',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName );
                    },
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                // Navigator.pushReplacementNamed(context, LoginScreen.routeName );
                loginProvider.isLoading = false;
              
              }


            },
          )

        ],
      ),
    );
  }
}