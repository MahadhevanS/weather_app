import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../screens/city_details_screen.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;
  final VoidCallback onDelete; // Callback for the delete action
  final List<WeatherData> weatherList;
  WeatherCard({required this.weatherData, required this.onDelete, required this.weatherList});



  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CityDetailsScreen(weatherDataList: weatherList,initialIndex: weatherList.indexOf(weatherData)),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Weather Icon
              Image.network(
                weatherData.iconUrl,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 16),
              // Weather Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherData.city,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${weatherData.temperature}°C",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      weatherData.condition,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              // Delete Icon
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
