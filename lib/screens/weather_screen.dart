import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../services/weather_service.dart';
import '../models/weather_data.dart';
import '../widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  List<WeatherData> weatherList = [];

  @override
  void initState() {
    super.initState();
    weatherList = weatherService.getStoredWeatherData();
  }

  // Add a new city to the weather list
  void addCity(String city) async {
    try {
      final weatherData = await weatherService.fetchWeather(city);
      setState(() {
        weatherList.add(weatherData);
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching weather for $city")),
      );
    }
  }

  // Delete a city from the weather list
  void deleteCity(String city) async {
    final weatherBox = await Hive.openBox('weatherBox');
    await weatherBox.delete(city);
    setState(() {
      weatherList.removeWhere((weatherData) => weatherData.city == city); // Remove from the list
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$city has been deleted.")),
    );
  }

  // Show dialog to add a new city
  void _showAddCityDialog() {
    final TextEditingController cityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[50],
          title: Text(
            'Add a City',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: cityController,
            decoration: InputDecoration(
              hintText: 'Enter city name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final cityName = cityController.text.trim();

                if (cityName.isEmpty) {
                  // Show error for empty input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("City name cannot be empty!")),
                  );
                  Navigator.pop(context);
                  return;
                }

                // Check for duplicate city
                final isCityAlreadyAdded = weatherList.any(
                        (weatherData) => weatherData.city.toLowerCase() == cityName.toLowerCase());

                if (isCityAlreadyAdded) {
                  // Show error for duplicate city
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$cityName is already added!")),
                  );
                  Navigator.pop(context);
                  return;
                }

                // Add city if valid
                addCity(cityName);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[200]!, Colors.blue[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 40),
            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Weather App",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Weather Cards
            Expanded(
              child: weatherList.isEmpty
                  ? Center(
                child: Text(
                  "No cities added yet.\nClick + to add a city.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: weatherList.length,
                itemBuilder: (context, index) {
                  return WeatherCard(
                    weatherData: weatherList[index],
                    onDelete: () => deleteCity(weatherList[index].city),
                    weatherList: weatherList,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCityDialog,
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.blue),
      ),
    );
  }
}
