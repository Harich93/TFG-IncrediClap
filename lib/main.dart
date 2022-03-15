import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incredibclap/helpers/player_audio.dart';
import 'package:incredibclap/models/models.dart';
import 'package:incredibclap/providers/audio_provider_player.dart';
import 'package:incredibclap/providers/providers.dart';
import 'package:incredibclap/screens/screens.dart';
import 'package:incredibclap/services/services.dart';
import 'package:provider/provider.dart';

void main() async { 
  // Provider.debugCheckInvalidValueType = null;
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
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => AudiosProvider()),
        ChangeNotifierProvider(create: ( _ ) => DurationModel()),
        ChangeNotifierProvider(create: ( _ ) => AudiosProviderPlayer()),
        ChangeNotifierProvider(create: ( _ ) => DurationModelPlayer()),
        ChangeNotifierProvider(create: ( _ ) => RecordService()),
        ChangeNotifierProvider(create: ( _ ) => MenuHidden()),
        ChangeNotifierProvider(create: ( _ ) => PlayerAudio(sDuration: Provider.of<DurationModelPlayer>(_, listen:false), sRecord: Provider.of<RecordService>(_,listen:false) ) ),
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
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName      : ( _ ) => const LoginScreen(),
        RegisterScreen.routeName   : ( _ ) => const RegisterScreen(),
        HomeScreen.routeName       : ( _ ) => const HomeScreen(),
        MusicScreen.routeName      : ( _ ) => const MusicScreen(),
        ListAudiosScreen.routeName : ( _ ) => const ListAudiosScreen(),
        PlayerScreen.routeName     : ( _ ) => PlayerScreen(),
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