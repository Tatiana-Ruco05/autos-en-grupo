// lib/views/loginScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_6/controllers/clientesController.dart';
import 'package:flutter_application_6/views/menuPrincipal.dart';
import 'package:flutter_application_6/views/registerScreen.dart'; // ← Correcto

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Paleta de colores
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  final correoController = TextEditingController();
  final passwordController = TextEditingController();
  final ClientesService clientesService = ClientesService();

  bool _isLoading = false;

  Future<void> iniciarSesion() async {
    if (_isLoading) return;

    final correo = correoController.text.trim();
    final password = passwordController.text;

    if (correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor completa todos los campos"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await clientesService.loginCliente(correo, password);

    setState(() => _isLoading = false);

    if (result['success'] == true && result.containsKey('cliente')) {
      final nombre = result['cliente']['nombre'] ?? 'Usuario';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("¡Bienvenido $nombre!"),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Pequeña pausa para que se vea el mensaje
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuPrincipal()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['mensaje'] ?? "Credenciales inválidas"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_car, size: 100, color: encabezado),
                const SizedBox(height: 20),
                Text(
                  "Bienvenido",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: encabezado,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Inicia sesión para alquilar tu vehículo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: texto.withOpacity(0.8)),
                ),
                const SizedBox(height: 50),

                // Campo correo
                TextField(
                  controller: correoController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: texto),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: campos,
                    labelText: "Correo electrónico",
                    prefixIcon: Icon(Icons.email, color: encabezado),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Campo contraseña
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: texto),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: campos,
                    labelText: "Contraseña",
                    prefixIcon: Icon(Icons.lock, color: encabezado),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón iniciar sesión
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : iniciarSesion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: boton,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Iniciar Sesión",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 40),

                // ¿No tienes cuenta?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿No tienes una cuenta? ", style: TextStyle(color: texto)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: Text(
                        "Regístrate",
                        style: TextStyle(
                          color: encabezado,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}