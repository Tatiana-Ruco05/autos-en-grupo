// lib/views/registerScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_6/controllers/clientesController.dart';
import 'package:flutter_application_6/views/loginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Colores de tu app
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  // Controladores
  final _nombresController = TextEditingController();
  final _correoController = TextEditingController();
  final _licenciaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmarPasswordController = TextEditingController();

  // Servicio
  final ClientesService clientesService = ClientesService();

  // Estado
  bool _isLoading = false;

  Future<void> registrarCliente() async {
    if (_isLoading) return;

    final nombre = _nombresController.text.trim();
    final correo = _correoController.text.trim();
    final numLic = _licenciaController.text.trim();
    final password = _passwordController.text;
    final confirmar = _confirmarPasswordController.text;

    // Validaciones básicas
    if (nombre.isEmpty || correo.isEmpty || numLic.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Todos los campos son obligatorios"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (password != confirmar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Las contraseñas no coinciden"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await clientesService.resgistrarCliente(
        nombre,
        correo,
        numLic,
        password,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("¡Cuenta creada con éxito!"),
            backgroundColor: Colors.green,
          ),
        );

        // Ir al login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['mensaje'] ?? "Error al registrarse"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error de conexión: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nombresController.dispose();
    _correoController.dispose();
    _licenciaController.dispose();
    _passwordController.dispose();
    _confirmarPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: encabezado),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.person_add_alt_1, size: 90, color: encabezado),
            const SizedBox(height: 20),
            Text(
              "Crear cuenta",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: encabezado,
              ),
            ),
            const SizedBox(height: 40),

            // Nombre
            TextField(
              controller: _nombresController,
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: "Nombre completo",
                prefixIcon: Icon(Icons.person, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Correo
            TextField(
              controller: _correoController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: "Correo electrónico",
                prefixIcon: Icon(Icons.email, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Licencia
            TextField(
              controller: _licenciaController,
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: "Número de licencia",
                prefixIcon: Icon(Icons.badge, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Contraseña
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: "Contraseña",
                prefixIcon: Icon(Icons.lock, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Confirmar contraseña
            TextField(
              controller: _confirmarPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: "Confirmar contraseña",
                prefixIcon: Icon(Icons.lock_outline, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Botón Crear cuenta
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : registrarCliente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: boton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Crear cuenta",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // Ya tienes cuenta?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿Ya tienes una cuenta? ", style: TextStyle(color: texto)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    "Iniciar sesión",
                    style: TextStyle(
                      color: encabezado,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}