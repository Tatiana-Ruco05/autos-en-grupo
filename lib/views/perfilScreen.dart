import 'package:flutter/material.dart';
import 'package:flutter_application_6/controllers/clientesController.dart';
import 'package:flutter_application_6/views/loginScreen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Map<String, String> usuario = {};

  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final datos = await ClientesService.obtenerUsuarioLogueado();
    if (mounted) {
      setState(() {
        usuario = datos;
      });
    }
  }

  Future<void> _cerrarSesion() async {
    await ClientesService.cerrarSesion();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: encabezado,
        title: const Text("Mi Perfil", style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 80, color: Color(0xFF60B5FF)),
            ),
            const SizedBox(height: 20),

            Text(
              usuario['nombre'] ?? 'Cargando...',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF222222)),
            ),
            Text(
              usuario['correo'] ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 40),

            _infoCard(Icons.person_outline, "Nombre completo", usuario['nombre'] ?? '-'),
            _infoCard(Icons.badge, "Número de licencia", usuario['numLic'] ?? '-'),
            _infoCard(Icons.email_outlined, "Correo", usuario['correo'] ?? '-'),

            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _cerrarSesion,
                icon: const Icon(Icons.exit_to_app),
                label: const Text("Cerrar Sesión", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String titulo, String valor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: encabezado, size: 30),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(valor, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}