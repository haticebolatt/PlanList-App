import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:planlistapp/data_task.dart';
import 'package:planlistapp/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //adMob ve sharedreferens için
  MobileAds.instance.initialize(); //adMOb için

  await DataTask().createPrefObject();

  runApp(ChangeNotifierProvider<DataTask>(
      create: (BuildContext context) => DataTask(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<DataTask>(context).loadItemsFromSharedPref();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xfff7e5cf),
     // primarySwatch:   Color(0xffece6e6),
        scaffoldBackgroundColor: const Color(0xfff7e5cf),
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: const SplashScreen(),
    );
  }
}

