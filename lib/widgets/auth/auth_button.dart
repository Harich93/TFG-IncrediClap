import 'package:flutter/material.dart';
import 'package:incredibclap/providers/login_provider.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatelessWidget {
  
  const AuthButton({
    Key? key,
    required this.text, 
    required this.onPressed
    
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {


    final loginProvider = Provider.of<LoginProvider>(context);
    
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: ThemeColors.primary,
      child: Container(
        padding: const  EdgeInsets.symmetric( horizontal: 80, vertical: 15),
        child: Text(
          loginProvider.isLoading
            ? 'Espere...'
            : text, 
          style: const TextStyle( color: Colors.white) 
        )
      ),
      onPressed: loginProvider.isLoading ? null : () async{

          FocusScope.of(context).unfocus(); // Quitar teclado
          
          loginProvider.isValidForm() 
            ? onPressed()
            : null;
      }
    );
  }
}