import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../widgets/weatherDetailCard.dart';
import '../widgets/forecastDetailCard.dart';



class CityDetailsScreen extends StatefulWidget {
  final List<WeatherData> weatherDataList; // List of WeatherData
  final int initialIndex; // Initial index for PageView

  CityDetailsScreen({required this.weatherDataList, required this.initialIndex});

  @override
  _CityDetailsScreenState createState() => _CityDetailsScreenState();
}

class _CityDetailsScreenState extends State<CityDetailsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Weather App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.weatherDataList.length,
        itemBuilder: (context, index) {
          return _buildWeatherScreen(widget.weatherDataList[index]);
        },
      ),
    );
  }

  Widget _buildWeatherScreen(WeatherData weatherData) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrentWeather(weatherData),
              SizedBox(height: 40),
              _buildWeatherDetailsGrid(weatherData),
              SizedBox(height: 40),
              _buildForecast(weatherData.forecast),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentWeather(WeatherData weatherData) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            weatherData.iconUrl,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            weatherData.city,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 10),
          Text(
            weatherData.condition,
            style: TextStyle(
              fontSize: 28,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid(WeatherData weatherData) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        buildWeatherDetailCard(Icons.air, "Wind Speed", "${weatherData.wind} km/h"),
        buildWeatherDetailCard(Icons.water_drop, "Humidity", "${weatherData.humidity}%"),
        buildWeatherDetailCard(Icons.speed, "Pressure", "${weatherData.pressure} hPa"),
        buildWeatherDetailCard(Icons.thermostat, "Temperature", "${weatherData.temperature}°C"),
      ],
    );
  }

  Widget _buildForecast(List<Map<String, dynamic>> forecast) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "10-Day Forecast",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.length,
              itemBuilder: (context, index) {
                final day = forecast[index];
                return buildForecastCard(day, index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
