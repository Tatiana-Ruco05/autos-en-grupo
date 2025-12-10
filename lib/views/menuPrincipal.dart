// lib/views/menuPrincipal.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_6/views/detalleVehiculo.dart';
import 'package:flutter_application_6/views/perfilScreen.dart'; // ← NUEVA PANTALLA
// import 'package:flutter_application_6/views/menuDrawerPerfil.dart'; // ← puedes dejarlo o borrarlo

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int _selectedIndex = 0; // para controlar el bottom bar

  // Paleta de colores
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  // Tus pantallas del bottom bar
  static final List<Widget> _pantallas = [
    const HomeConCarros(),           // ← Tu lista actual de carros
    const MisAlquileresScreen(),     // ← Puedes hacer esta pantalla después
    const PerfilScreen(),            // ← AQUÍ VA EL PERFIL DIRECTO
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      // drawer: const MenuDrawerPerfil(), // ← si quieres mantener el drawer lateral, descomenta esta línea
      appBar: AppBar(
        title: const Text('Alquiler de Vehículos'),
        backgroundColor: encabezado,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pantallas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: boton,
        unselectedItemColor: texto.withOpacity(0.6),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Alquiler'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// ===============================================
// TU LISTA DE CARROS (exactamente como la tenías)
// ===============================================
class HomeConCarros extends StatelessWidget {
  const HomeConCarros({super.key});

  final Color campos = const Color(0xFFFFECDB);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color texto = const Color(0xFF222222);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Buscador
          TextField(
            style: TextStyle(color: texto),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: encabezado),
              hintText: 'Buscar vehículo',
              hintStyle: TextStyle(color: texto.withOpacity(0.7)),
              filled: true,
              fillColor: campos,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Lista de vehículos
          Expanded(
            child: ListView.builder(
              itemCount: listaDeAutos.length,
              itemBuilder: (context, index) {
                final auto = listaDeAutos[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(auto['imageUrl'], width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text('${auto['marca']} ${auto['modelo']}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Año: ${auto['anio']}  •  Precio: \$${auto['precio']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFFF9149)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleVehiculoScreen(
                            imageUrl: auto['imageUrl'],
                            marca: auto['marca'],
                            modelo: auto['modelo'],
                            anio: auto['anio'],
                            disponibilidad: auto['disponibilidad'],
                            precio: auto['precio'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Pantalla temporal para "Alquiler" (puedes mejorarla después)
class MisAlquileresScreen extends StatelessWidget {
  const MisAlquileresScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Mis Alquileres\n(Próximamente)",
        style: TextStyle(fontSize: 20, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ===============================================
// TUS DATOS DE EJEMPLO (NO TOCAR)
// ===============================================
final List<Map<String, dynamic>> listaDeAutos = [
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Toyota",
    "modelo": "Corolla",
    "anio": 2020,
    "disponibilidad": true,
    "precio": 15000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Honda",
    "modelo": "Civic",
    "anio": 2019,
    "disponibilidad": false,
    "precio": 14000
  },
  // ... (el resto de tus 15 carros)
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Renault",
    "modelo": "Clio",
    "anio": 2020,
    "disponibilidad": true,
    "precio": 14000
  },
];