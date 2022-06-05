import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/services.dart';
import 'package:provider/provider.dart';

void main() async { 
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
        ChangeNotifierProvider(create: ( _ ) => UiProvider()),
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => AudiosProvider()),
        ChangeNotifierProvider(create: ( _ ) => DurationModel()),
        ChangeNotifierProvider(create: ( _ ) => RecordService()),
        ChangeNotifierProvider(create: ( _ ) => MenuHidden()),
        ChangeNotifierProvider(create: ( _ ) => PlayerAudio(sDuration: Provider.of<DurationModel>(_, listen:false), sRecord: Provider.of<RecordService>(_,listen:false) ) ),
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
      title: 'IncrediClap',
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName        : ( _ ) => const LoginScreen(),
        RegisterScreen.routeName     : ( _ ) => const RegisterScreen(),
        HomeScreen.routeName         : ( _ ) => const HomeScreen(),
        SettingsUserScreen.routeName : ( _ ) => const SettingsUserScreen(), 
        ListAudiosScreen.routeName   : ( _ ) => const ListAudiosScreen(), 
        PlayerScreen.routeName       : ( _ ) => PlayerScreen(),
      },
    );
  }


}

void configStatusBar(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true
      )
  );
}