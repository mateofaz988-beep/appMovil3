import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Catalog_screen.dart';
import 'package:flutter_application_1/screens/auth_screen.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';


void main() {
  runApp(const MovieStreamApp());
}

class MovieStreamApp extends StatelessWidget {
  const MovieStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieStream',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark, // Modo oscuro para estilo de cine
        ),
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/auth': (context) => const AuthScreen(),
        '/catalog': (context) => const CatalogScreen(),
      },
    );
  }
}