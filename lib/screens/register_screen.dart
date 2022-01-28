import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {

static const String routeName = 'Register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('RegisterScreen'),
      ),
    );
  }

}