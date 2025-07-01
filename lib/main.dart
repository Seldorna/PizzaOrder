import 'package:flutter/material.dart';
import 'ui/app.dart';
import 'package:pizza_order/ui/screens/home_screen.dart';

void main() => runApp(const PizzaApp());

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Palace',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}