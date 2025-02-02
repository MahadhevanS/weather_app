import 'package:hive/hive.dart';

part 'weather_data.g.dart';

@HiveType(typeId: 0)
class WeatherData {
  @HiveField(0)
  final String city;

  @HiveField(1)
  final double temperature;

  @HiveField(2)
  final String condition;

  @HiveField(3)
  final String iconUrl;

  @HiveField(4)
  final double wind;

  @HiveField(5)
  final int humidity;

  @HiveField(6)
  final double pressure;

  @HiveField(7)
  final List<Map<String, dynamic>> forecast;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    required this.wind,
    required this.humidity,
    required this.pressure,
    required this.forecast
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> forecast = [];
    if (json['forecast'] != null && json['forecast']['forecastday'] != null) {
      forecast = List<Map<String, dynamic>>.from(json['forecast']['forecastday']);
    }

    return WeatherData(
        city: json['location']['name'] ?? 'Unknown City',
        temperature: json['current']['temp_c'] ?? 0.0,
        condition: json['current']['condition']['text'] ?? 'Unknown',
        iconUrl: "https:${json['current']['condition']['icon'] ?? ''}",
        wind: json['current']['wind_kph'] ?? 0.0,
        humidity: json['current']['humidity'] ?? 0,
        pressure: json['current']['pressure'] ?? 0.0,
        forecast: forecast
    );
  }
}
