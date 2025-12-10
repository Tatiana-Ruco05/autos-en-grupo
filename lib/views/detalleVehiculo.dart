import 'package:flutter/material.dart';

class DetalleVehiculoScreen extends StatefulWidget {
  final String imageUrl;
  final String marca;
  final String modelo;
  final int anio;
  final bool disponibilidad;
  final int precio;

  const DetalleVehiculoScreen({
    super.key,
    required this.imageUrl,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.disponibilidad,
    required this.precio,
  });

  @override
  State<DetalleVehiculoScreen> createState() => _DetalleVehiculoScreenState();
}

class _DetalleVehiculoScreenState extends State<DetalleVehiculoScreen> {
  // Paleta de colores unificada
  final Color fondo = const Color(0xFFAFDDFF);
  final Color encabezado = const Color(0xFF60B5FF);
  final Color campos = const Color(0xFFFFECDB);
  final Color boton = const Color(0xFFFF9149);
  final Color texto = const Color(0xFF222222);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: encabezado,
        foregroundColor: Colors.white,
        title: Text('${widget.marca} ${widget.modelo}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: campos,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Imagen del vehículo
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.imageUrl,
                    height: 160,
                    width: 260,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // Nombre del vehículo
                Text(
                  '${widget.marca} ${widget.modelo}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: texto,
                  ),
                ),
                const SizedBox(height: 8),

                // Año
                Text(
                  'Año: ${widget.anio}',
                  style: TextStyle(fontSize: 18, color: texto.withOpacity(0.8)),
                ),
                const SizedBox(height: 8),

                // Chip de disponibilidad
                Chip(
                  avatar: Icon(
                    widget.disponibilidad
                        ? Icons.check_circle
                        : Icons.cancel_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    widget.disponibilidad
                        ? 'Disponible'
                        : 'No disponible',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor:
                      widget.disponibilidad ? Colors.green : Colors.grey,
                ),
                const SizedBox(height: 12),

                // Precio
                Text(
                  'Precio: \$${widget.precio}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: boton,
                  ),
                ),
                const SizedBox(height: 24),

                // Botón para solicitar alquiler
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: boton,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: widget.disponibilidad
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Solicitud enviada.')),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.directions_car),
                  label: const Text(
                    'Solicitar alquiler',
                    style: TextStyle(fontSize: 16),
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
