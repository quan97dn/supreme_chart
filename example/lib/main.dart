// Cores
import 'package:flutter/material.dart';
import 'package:supreme_chart/supreme_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: MonthlyLineChart(
          levelAmplitude: [20, 30, 10, 50, 70, 80],
          activeMonth: 3,
        ),
      ),
    );
  }
}
