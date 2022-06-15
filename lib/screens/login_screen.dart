import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:incredibclap/themes/input_decoration.dart';
import 'package:provider/provider.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/services.dart';
import 'package:incredibclap/themes/colors.dart';
import 'package:incredibclap/widgets/auth/auth.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = 'Login';

  


  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    final size = MediaQuery.of(context).size;
    final authS = Provider.of<AuthService>(context);

    String email = '';

    Future<void> _changePassDialog() async { 

      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Restablecer contraseña'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text('Igrese email'),
                  const SizedBox(height: 20),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecorations.authInput(
                      hintText: 'Email...',
                      labelText: 'Email',
                      color: ThemeColors.primary
                    ),
                    onChanged: ( value ) => email = value,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop()
              ),

              TextButton(
                child: const Text('Aceptar'),
                onPressed: () async {
                  String msg = '';
                  final res = await authS.resetPass(email);
                  
                  if(res['error'] != null) { msg = res['error'];}
                  else{ msg = 'Compruebe su correo';}

                  final snackBar = SnackBar(
                    content: Text(msg),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () {},
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                },
              ),

              
            ]
          );
        },
      );
    }

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * .27),
              
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
              
              SizedBox( height: size.height * .04 ),
              TextButtonAuth(text: 'Crear cuenta', onPressed: () => Navigator.pushReplacementNamed(context,RegisterScreen.routeName)),
              TextButtonAuth(text: '¿Has olvidado la contraseña?', onPressed: () => _changePassDialog()),
              SizedBox( height: size.height * .04 ),
              
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
            color: ThemeColors.primary,
          ),
          
          const SizedBox( height: 30),
          
          InputPass(
            loginProvider: loginProvider,
            color: ThemeColors.primary,
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
                loginProvider.isLoading = false;
              }
              else {
                loginProvider.isLoading = false;
              }

            },
          ),

          const SizedBox(height: 15),

          const _RecordMe(),
        
        ],
      ),
    );
  }

  bool _isError( LoginProvider loginProvider, Map<String,dynamic> resp ) {
    
    if( resp['msg'] != null) {
      loginProvider.isError = true;
      loginProvider.textError = resp['msg'];
      Timer(const Duration(seconds: 4), () => loginProvider.isError = false );
      loginProvider.isLoading = false;
      return true;
    }

    return false;
  }

  _savePreferncesResp( Map<String,dynamic> resp ){

    try {
      Preferences.name = resp['user']['name'];
      Preferences.token = resp['token'];
      
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    
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


