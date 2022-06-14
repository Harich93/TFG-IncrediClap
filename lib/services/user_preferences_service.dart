import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _prefs;

  static String _name = '';
  static String _email = '';
  static String _password = '';
  static String _token = '';
  static int _idImg = 0;
  static bool _recordUser = false;

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

  // <-- Password -->
  static String get password {
    return _prefs.getString('password') ?? _password;
  }

  static set password( String value ) {
    _password = value;
    _prefs.setString('password', _password);
  }

  // <-- Password -->
  static int get idImg {
    return _prefs.getInt('idImg') ?? _idImg;
  }

  static set idImg( int value ) {
    _idImg = value;
    _prefs.setInt('idImg', _idImg);
  }
  

  // <-- recordUser -->
  static bool get recordUser {
    return _prefs.getBool('recordUser') ?? _recordUser;
  }

  static set recordUser( bool value ) {
    _recordUser = value;
    _prefs.setBool('recordUser', _recordUser);
  }

}