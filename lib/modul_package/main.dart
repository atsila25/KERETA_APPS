import 'package:flutter/material.dart';
import 'package:prakmob3/modul_package/imageLat1.dart';
import 'package:prakmob3/modul_package/spLat2.dart';
import 'package:prakmob3/modul_package/share_preferences.dart';
import 'package.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: //DataFetchPage(), //Memanggil Data Fetch
            //CounterPage(), // Memanggil halaman CounterPage
            ImageDisplayScreen(), //Memanggil halaman ImageDisplayScreen
            //ThemeSettingsPage(), //Memanggil halaman theme settings page
    );
  }
}
