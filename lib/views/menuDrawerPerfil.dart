import 'package:flutter/material.dart';

class MenuDrawerPerfil extends StatefulWidget {
  @override
  _MenuDrawerPerfilState createState() => _MenuDrawerPerfilState();
}

class _MenuDrawerPerfilState extends State<MenuDrawerPerfil> {
  // Controlador para el campo de texto de revisión de alquileres
  final TextEditingController _rentalController = TextEditingController();

  // 🎨 Paleta unificada
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  @override
  void dispose() {
    _rentalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: fondo,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Encabezado del perfil
            Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/profile_pic.jpg'),
                ),
                const SizedBox(height: 12),
                Text(
                  "Nombre de Usuario",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: texto,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "correo@ejemplo.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: texto.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Información del perfil
            ListTile(
              leading: Icon(Icons.badge, color: encabezado),
              title: Text("Número de licencia",
                  style: TextStyle(color: texto, fontWeight: FontWeight.w500)),
              subtitle: Text("123456789",
                  style: TextStyle(color: texto.withOpacity(0.8))),
            ),
            const Divider(),

            ListTile(
              leading: Icon(Icons.lock, color: encabezado),
              title: Text("Cambiar contraseña",
                  style: TextStyle(color: texto, fontWeight: FontWeight.w500)),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidad en desarrollo')),
                );
              },
            ),
            const Divider(),

            ListTile(
              leading: Icon(Icons.search_rounded, color: boton),
              title: Text("Revisar Alquileres",
                  style: TextStyle(color: texto, fontWeight: FontWeight.w500)),
            ),

            const SizedBox(height: 12),

            // Campo de texto
            TextField(
              controller: _rentalController,
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                filled: true,
                fillColor: campos,
                labelText: 'Número de alquiler o placa',
                labelStyle: TextStyle(color: texto),
                prefixIcon: Icon(Icons.directions_car, color: encabezado),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botón buscar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: boton,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                final valor = _rentalController.text.trim();
                if (valor.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ingrese un número o placa')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Buscando alquiler para: $valor...')),
                  );
                }
              },
              child: const Text(
                'Buscar Alquiler',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 30),

            // Cerrar sesión
            ListTile(
              leading: Icon(Icons.exit_to_app, color: boton),
              title: Text(
                "Cerrar sesión",
                style: TextStyle(
                    color: texto, fontWeight: FontWeight.w600, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sesión cerrada.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
