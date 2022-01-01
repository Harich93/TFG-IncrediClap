import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/screens/create_music._screen.dart';

import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/auth_service.dart';
import 'package:incredibclap/services/user_preferences_service.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  configStatusBar();
  runApp( const AppState() );
  
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: CreateMusicScreen.routeName,
      routes: {
        AccountScreen.routeName     : ( _ ) => const AccountScreen(),
        IntroScreen.routeName       : ( _ ) => const IntroScreen(),
        LoginScreen.routeName       : ( _ ) => const LoginScreen(),
        HomeScreen.routeName        : ( _ ) => const HomeScreen(),
        RegisterScreen.routeName    : ( _ ) => const RegisterScreen(),
        CreateMusicScreen.routeName : ( _ ) => const CreateMusicScreen(), 
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(185, 226, 140, 1),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark
          )
        )
      ),

      
    );
  }

}


void configStatusBar(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true
      )
  );
}