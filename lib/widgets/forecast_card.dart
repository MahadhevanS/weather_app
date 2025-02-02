

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildForecastCard(Map<String, dynamic> day) {
  return Card(
    color: Colors.white.withOpacity(0.8),
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day['date'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Image.network(
            "https:${day['day']['condition']['icon']}",
            width: 50,
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            "${day['day']['maxtemp_c']}°C / ${day['day']['mintemp_c']}°C",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            day['day']['condition']['text'],
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    ),
  );
}
