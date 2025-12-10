import 'package:flutter/material.dart';
import 'package:flutter_application_6/views/detalleVehiculo.dart';
import 'package:flutter_application_6/views/menuDrawerPerfil.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  // 🎨 Paleta unificada (misma del login/registro)
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      drawer: MenuDrawerPerfil(),
      appBar: AppBar(
        title: const Text('Alquiler de Vehículos'),
        backgroundColor: encabezado,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔎 Cuadro de búsqueda con icono
            TextField(
              style: TextStyle(color: texto),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: encabezado),
                hintText: 'Buscar vehículo',
                hintStyle: TextStyle(color: texto.withOpacity(0.7)),
                labelStyle: TextStyle(color: texto),
                filled: true,
                fillColor: campos,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // 🚗 Lista de vehículos
            Expanded(
              child: ListView.builder(
                itemCount: listaDeAutos.length,
                itemBuilder: (BuildContext context, int index) {
                  final auto = listaDeAutos[index];

                  return Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          auto['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        '${auto['marca']} ${auto['modelo']}',
                        style: TextStyle(color: texto, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Año: ${auto['anio']}  •  Precio: \$${auto['precio']}',
                        style: TextStyle(color: texto.withOpacity(0.8)),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: boton),
                      onTap: () {
                        // ✅ Tipos correctos al detalle
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleVehiculoScreen(
                              imageUrl: auto['imageUrl'] as String,
                              marca: auto['marca'] as String,
                              modelo: auto['modelo'] as String,
                              anio: auto['anio'] as int,
                              disponibilidad: auto['disponibilidad'] as bool,
                              precio: auto['precio'] as int,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: boton,
        unselectedItemColor: texto.withOpacity(0.6),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Alquiler'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuario'),
        ],
      ),
    );
  }
}

////////////////////////////
// Datos de ejemplo
List<Map<String, dynamic>> listaDeAutos = [
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
    "modelo": "Focus",
    "anio": 2021,
    "disponibilidad": true,
    "precio": 16000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Chevrolet",
    "modelo": "Cruze",
    "anio": 2018,
    "disponibilidad": true,
    "precio": 12000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Hyundai",
    "modelo": "Elantra",
    "anio": 2022,
    "disponibilidad": false,
    "precio": 17000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Nissan",
    "modelo": "Sentra",
    "anio": 2020,
    "disponibilidad": true,
    "precio": 14500
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Mazda",
    "modelo": "Mazda3",
    "anio": 2021,
    "disponibilidad": true,
    "precio": 15500
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Kia",
    "modelo": "Forte",
    "anio": 2019,
    "disponibilidad": false,
    "precio": 13500
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Volkswagen",
    "modelo": "Jetta",
    "anio": 2021,
    "disponibilidad": true,
    "precio": 16500
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Subaru",
    "modelo": "Impreza",
    "anio": 2018,
    "disponibilidad": true,
    "precio": 13000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "BMW",
    "modelo": "Serie 3",
    "anio": 2020,
    "disponibilidad": false,
    "precio": 25000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Mercedes-Benz",
    "modelo": "Clase C",
    "anio": 2019,
    "disponibilidad": true,
    "precio": 27000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Audi",
    "modelo": "A4",
    "anio": 2022,
    "disponibilidad": true,
    "precio": 29000
  },
  {
    "imageUrl": "https://picsum.photos/330/200",
    "marca": "Peugeot",
    "modelo": "208",
    "anio": 2021,
    "disponibilidad": false,
    "precio": 18000
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
