import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'models/weather_data.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(WeatherDataAdapter());

  await Hive.openBox('weatherBox');

  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}
