import 'package:flutter/material.dart';
import 'package:flutter_application_6/views/detalleVehiculo.dart';
import 'package:flutter_application_6/views/perfilScreen.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  int _selectedIndex = 0;

  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  static final List<Widget> _pantallas = [
    const HomeConCarros(),
    const MisAlquileresScreen(),
    const PerfilScreen(),
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

class HomeConCarros extends StatelessWidget {
  const HomeConCarros({super.key});

  final Color campos = const Color(0xFFFFECDB);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Vehículos disponibles',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF222222)),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listaDeAutos.length,
          itemBuilder: (context, index) {
            final auto = listaDeAutos[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
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
      ],
    );
  }
}

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
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Ford",
    "modelo": "Mustang",
    "anio": 2021,
    "disponibilidad": true,
    "precio": 25000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Chevrolet",
    "modelo": "Camaro",
    "anio": 2022,
    "disponibilidad": true,
    "precio": 22000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Volkswagen",
    "modelo": "Golf",
    "anio": 2018,
    "disponibilidad": false,
    "precio": 13000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "BMW",
    "modelo": "3 Series",
    "anio": 2023,
    "disponibilidad": true,
    "precio": 30000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Mercedes",
    "modelo": "C-Class",
    "anio": 2020,
    "disponibilidad": true,
    "precio": 28000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Audi",
    "modelo": "A4",
    "anio": 2019,
    "disponibilidad": false,
    "precio": 26000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Nissan",
    "modelo": "Altima",
    "anio": 2021,
    "disponibilidad": true,
    "precio": 16000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Hyundai",
    "modelo": "Elantra",
    "anio": 2022,
    "disponibilidad": true,
    "precio": 14000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Kia",
    "modelo": "Forte",
    "anio": 2020,
    "disponibilidad": false,
    "precio": 13000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Subaru",
    "modelo": "Impreza",
    "anio": 2019,
    "disponibilidad": true,
    "precio": 17000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Mazda",
    "modelo": "3",
    "anio": 2021,
    "disponibilidad": true,
    "precio": 15000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Tesla",
    "modelo": "Model 3",
    "anio": 2023,
    "disponibilidad": false,
    "precio": 35000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Renault",
    "modelo": "Clio",
    "anio": 2020,
    "disponibilidad": true,
    "precio": 14000
  },
];