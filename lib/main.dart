import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/audio_provider.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/services.dart';
import 'package:provider/provider.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  configStatusBar();
  return runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(create: ( _ ) => AudiosProvider()),
        ChangeNotifierProvider(create: ( _ ) => DurationModel())
      ],
      child: MyApp(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: HomeScreen.routeName,
      routes: {
        LoginScreen.routeName    : ( _ ) => const LoginScreen(),
        RegisterScreen.routeName : ( _ ) => const RegisterScreen(),
        HomeScreen.routeName     : ( _ ) => const HomeScreen(),
        MusicScreen.routeName    : ( _ ) => const MusicScreen(),
      },
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