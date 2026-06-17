import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos SafeArea para que el contenido no se tape con la barra de estado
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono decorativo de bienvenida
                const Icon(Icons.movie_creation_outlined, size: 100, color: Colors.blueAccent),
                const SizedBox(height: 30),
                
                // Mensaje de Bienvenida
                const Text(
                  "Bienvenido a MovieStream",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                
                // Breve descripción
                const Text(
                  "Accede a un catálogo exclusivo de películas y disfruta de tus estrenos favoritos en cualquier lugar.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                
                // Botón Iniciar Sesión
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // Acción para navegar a Auth_screen
                    },
                    child: const Text("Iniciar Sesión"),
                  ),
                ),
                const SizedBox(height: 15),
                
                // Botón Registrarse
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Acción para navegar a Auth_screen
                    },
                    child: const Text("Registrarse"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}