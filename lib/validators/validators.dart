class Validators {

  static String? email( String? value ) {

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    
    RegExp regExp  = RegExp(pattern);

    return regExp.hasMatch(value ?? '' )
      ? null
      : 'Email no válido';
  }

  static String? pass( String? value, bool isLogin, bool isRequired) {
    if(isRequired) {
      return ( value != null  && value.length >= 6 )
        ? null
        : isLogin ? 'Contraseña no válida'  : 'Debe tener minimo 6 caracteres';
    }
    
    return null;
  }
  
  static String? passMatch( String? value, String? value2 ) {

    if ((value != '' && value2 != '') && (value != value2)) {
      return 'Las contraseñas no coinciden';
    }

    else if((value != '' && value2 != '') && (value!.length < 6 && value2!.length <6) ) {
      return 'Debe tener minimo 6 caracteres';
    }

    return null;

  }

    static String? name( String? value ) {
    return ( value != null && value.length >= 2 )
      ? null
      : 'Nombre requerido';
  }

}