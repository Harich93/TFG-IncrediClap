import 'package:flutter/material.dart';
import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/themes/input_decorations.dart';
import 'package:incredibclap/validators/validators.dart';

class InputPass extends StatelessWidget {
  const InputPass({
    Key? key,
    required this.loginProvider, 
  }) : super(key: key);

  final LoginProvider loginProvider;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecorations.authInput(
        hintText: 'Password',
        labelText: 'Contraseña',
        prefixIcon: Icons.lock_outline
      ),
      onChanged: ( value ) => loginProvider.password = value,
      validator: ( value ) => Validators.pass(value) ,
    );
  }
}

// ignore: must_be_immutable
class InputEmail extends StatelessWidget {
  InputEmail({
    Key? key,
    required this.loginProvider,
    this.email
  }) : super(key: key);

  final LoginProvider loginProvider;
  String? email = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      initialValue: email,
      decoration: InputDecorations.authInput(
        hintText: 'example@gmail.com',
        labelText: 'Email',
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
    this.name
  }) : super(key: key);

  final LoginProvider loginProvider;
  String? name;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.name,
      initialValue: name,
      decoration: InputDecorations.authInput(
        hintText: 'Usuario',
        labelText: 'Nombre',
        prefixIcon: Icons.account_circle_outlined
      ),
      onChanged: ( value ) => loginProvider.name = value,
      validator: ( value ) => Validators.name(value) ,
    );
  }
}