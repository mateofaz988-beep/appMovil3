import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Welcome_screen.dart';
import 'package:flutter_application_1/screens/Auth_screen.dart';
import 'package:flutter_application_1/screens/Catalog_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieStream',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141414),
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