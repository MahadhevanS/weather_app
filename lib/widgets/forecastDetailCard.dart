import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildForecastCard(Map<String, dynamic> day, int index) {
  String dateLabel;

  if (index == 0) {
    dateLabel = "Today";
  } else if (index == 1) {
    dateLabel = "Tomorrow";
  } else {
    DateTime date = DateTime.parse(day['date']);
    dateLabel = DateFormat('dd/MM').format(date);
  }

  return Card(
    color: Colors.white.withOpacity(0.8),
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dateLabel,
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