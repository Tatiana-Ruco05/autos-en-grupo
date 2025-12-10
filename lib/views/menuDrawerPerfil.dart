import 'package:flutter/material.dart';
import 'package:flutter_application_6/controllers/clientesController.dart';
import 'package:flutter_application_6/views/loginScreen.dart';

class MenuDrawerPerfil extends StatefulWidget {
  const MenuDrawerPerfil({super.key});

  @override
  State<MenuDrawerPerfil> createState() => _MenuDrawerPerfilState();
}

class _MenuDrawerPerfilState extends State<MenuDrawerPerfil> {
  Map<String, String> usuario = {};
  final TextEditingController _rentalController = TextEditingController();

  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
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
  void dispose() {
    _rentalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: fondo,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF60B5FF)),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Color(0xFF60B5FF)),
                ),
                const SizedBox(height: 12),
                Text(
                  usuario['nombre'] ?? 'Cargando...',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  usuario['correo'] ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          _itemPerfil(Icons.person, "Nombre", usuario['nombre'] ?? '-'),
          _itemPerfil(Icons.badge, "Licencia", usuario['numLic'] ?? '-'),

          const Divider(height: 40, thickness: 1),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _rentalController,
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: 'Placa o número de alquiler',
                prefixIcon: Icon(Icons.directions_car, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                final texto = _rentalController.text.trim();
                if (texto.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ingresa placa o número')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buscando: $texto...')),
                  );
                }
              },
              icon: const Icon(Icons.search),
              label: const Text('Buscar Alquiler'),
              style: ElevatedButton.styleFrom(backgroundColor: boton),
            ),
          ),

          const SizedBox(height: 30),

          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              "Cerrar sesión",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: _cerrarSesion,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _itemPerfil(IconData icon, String titulo, String valor) {
    return ListTile(
      leading: Icon(icon, color: encabezado),
      title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(valor, style: TextStyle(color: texto.withOpacity(0.8))),
    );
  }
}