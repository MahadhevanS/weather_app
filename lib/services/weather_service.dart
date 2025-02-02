import 'package:hive/hive.dart';
import '../models/weather_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final Box weatherBox = Hive.box('weatherBox');

  Future<WeatherData> fetchWeather(String city) async {
    final apiKey = "3c3a5fa81f4c4b929d872805252501";
    final url =
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=10&aqi=no&alerts=no"
        ;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final weatherData = WeatherData.fromJson(jsonDecode(response.body));

      await weatherBox.put(city, weatherData);

      return weatherData;
    } else {
      throw Exception("Failed to fetch weather data for $city");
    }
  }

  List<WeatherData> getStoredWeatherData() {
    return weatherBox.values.toList().cast<WeatherData>();
  }
}
