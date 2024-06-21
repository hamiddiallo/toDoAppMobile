import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart';

// Point d'entrée de l'application
void main() {
  runApp(const MyApp());
}

// Définition de l'application principale en tant que widget Stateless
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo App', // Titre de l'application
      theme: ThemeData(
        primarySwatch: Colors.blue, // Définition du thème principal de l'application
      ),
      home: const HomeScreen(), // Écran principal de l'application
    );
  }
}
