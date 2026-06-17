import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Auth_screen.dart';
import 'screens/welcome_screen.dart';

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
          brightness: Brightness.light,
        ),
      ),
      // Definimos la ruta inicial
      initialRoute: '/welcome',
      // Definimos las rutas disponibles
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/auth': (context) => const AuthScreen(),
      },
    );
  }
}