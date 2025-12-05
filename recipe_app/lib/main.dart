import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/recipe_provider.dart';
import 'screens/welcome_screen.dart';   // 👈 NEW IMPORT
// (CategoryScreen will be imported inside welcome_screen.dart)

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),   // 👈 START HERE NOW
    );
  }
}
