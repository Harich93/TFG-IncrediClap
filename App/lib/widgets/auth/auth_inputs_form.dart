import 'package:flutter/material.dart';
import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/themes/input_decoration.dart';
import 'package:incredibclap/validators/validators.dart';

// ignore: must_be_immutable
class InputPass extends StatelessWidget {
  InputPass({
    Key? key,
    required this.loginProvider,
    required this.color,
    this.confirmPass = false,
    this.isRequired = true, 
    this.pass, 
    this.placeholder = 'Password',
    this.label = 'Contraseña',
  }) : super(key: key);

  final LoginProvider loginProvider;
  Color color;
  bool confirmPass;
  bool isRequired;
  String? pass = '';
  String placeholder = '';
  String label = '';
  


  @override
  Widget build(BuildContext context) {
    
    if( pass != null ) loginProvider.password = pass!; 
    
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      initialValue: pass,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecorations.authInput(
        hintText: placeholder,
        labelText: label,
        color: color,
        prefixIcon: Icons.lock_outline
      ),
      onChanged: ( value ) => confirmPass ? loginProvider.password2 = value : loginProvider.password = value,
      validator: ( value ) => confirmPass ? Validators.passMatch(value, loginProvider.password) : Validators.pass(value, false, isRequired) ,
    );
  }
}

// ignore: must_be_immutable
class InputEmail extends StatelessWidget {
  InputEmail({
    Key? key,
    required this.loginProvider,
    required this.color,
    this.email = ''
  }) : super(key: key);

  final LoginProvider loginProvider;
  Color color;
  String? email;

  @override
  Widget build(BuildContext context) {
    
    if( email != '' ) loginProvider.email = email!;

    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      initialValue: email,
      decoration: InputDecorations.authInput(
        hintText: 'example@gmail.com',
        labelText: 'Email',
        color: color,
        prefixIcon: Icons.alternate_email
      ),
      onChanged: ( value ) => loginProvider.email = value,
      validator: ( value ) => Validators.email(value) ,
    );
  }
}

// ignore: must_be_immutable
class InputName extends StatelessWidget {
  InputName({
    Key? key,
    required this.loginProvider,
    required this.color,
    this.name
  }) : super(key: key);

  final LoginProvider loginProvider;
  Color color;
  String? name;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.name,
      initialValue: name,
      decoration: InputDecorations.authInput(
        hintText: 'Usuario',
        labelText: 'Nombre usuario',
        color: color,
        prefixIcon: Icons.account_circle_outlined
      ),
      onChanged: ( value ) => loginProvider.name = value,
      validator: ( value ) => Validators.name(value) ,
    );
  }
}