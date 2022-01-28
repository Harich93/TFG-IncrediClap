import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _prefs;

  static String _name = '';
  static String _email = '';
  static String _token = '';

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  // <-- Name -->
  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name( String value ) {
    _name = value;
    _prefs.setString('name', _name);
  }


  // <-- Token -->
  static String get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token( String value ) {
    _token = value;
    _prefs.setString('token', _token);
  }


  // <-- Email -->
  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email( String value ) {
   _email = value;
    _prefs.setString('email', _email);
  }

}