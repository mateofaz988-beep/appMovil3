import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _isLogin ? "INICIAR SESIÓN" : "REGISTRARSE",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fondoregistro.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.8),
                  const Color(0xFF141414),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isLogin ? Icons.lock_person_rounded : Icons.person_add_alt_1_rounded,
                      size: 80,
                      color: const Color(0xFF00F5D4),
                    ),
                    const SizedBox(height: 30),
                    
                    if (!_isLogin) ...[
                      TextFormField(
                        style: GoogleFonts.poppins(color: Colors.white),
                        decoration: _inputDecoration("Nombre", Icons.person_outline),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: GoogleFonts.poppins(color: Colors.white),
                        decoration: _inputDecoration("Apellido", Icons.badge_outlined),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: GoogleFonts.poppins(color: Colors.white),
                        decoration: _inputDecoration("Edad", Icons.cake_outlined),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: GoogleFonts.poppins(color: Colors.white),
                        decoration: _inputDecoration("País", Icons.public_outlined),
                      ),
                      const SizedBox(height: 15),
                    ],
                    
                    TextFormField(
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: _inputDecoration("Correo electrónico", Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      style: GoogleFonts.poppins(color: Colors.white),
                      decoration: _inputDecoration("Contraseña", Icons.lock_outline),
                      obscureText: true,
                    ),
                    const SizedBox(height: 40),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00F5D4),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 10,
                          shadowColor: const Color(0xFF00F5D4).withOpacity(0.5),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacementNamed(context, '/catalog');
                          }
                        },
                        child: Text(
                          _isLogin ? "ENTRAR" : "REGISTRAR",
                          style: GoogleFonts.poppins(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold, 
                            letterSpacing: 1
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin 
                            ? "¿No tienes cuenta? Regístrate aquí" 
                            : "¿Ya tienes cuenta? Inicia sesión",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.white54),
      prefixIcon: Icon(icon, color: const Color(0xFF00F5D4)),
      filled: true,
      fillColor: Colors.black.withOpacity(0.6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF00F5D4), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
} 