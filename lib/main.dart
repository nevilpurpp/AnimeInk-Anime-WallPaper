import 'package:flutter/material.dart';
import 'package:anime_wallpaper/Screens/Splash.dart';
import 'package:provider/provider.dart';

import 'constants/styles/themes.dart';
import 'provider/get_data_provider.dart';
import 'utils/util.dart';


void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (ctx) => GetDataProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
        home: const Splash(),
      ),
    );
  }
}
//To Do
//Drawer

  //set about us,
  //theme
  //rating
 
//Utils
   // //no internet connection widget