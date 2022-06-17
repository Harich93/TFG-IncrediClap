import 'package:flutter/material.dart';
import 'package:incredibclap/models/user_model.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/services/services.dart';

class LoginProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  

  String name = Preferences.name;
  String email = '';
  String password = '';
  String password2 = '';

  String textError = '';
  
  User _connectedUser = User();

  bool _isError = false;
  bool get isError => _isError;
  
  set isError( bool value ) {
    _isError = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  User get connectedUser => _connectedUser;  
  set connectedUser( User user ) {
    _connectedUser = user;
    notifyListeners();
  }

  bool isValidForm() =>  formKey.currentState?.validate() ?? false;
  
}