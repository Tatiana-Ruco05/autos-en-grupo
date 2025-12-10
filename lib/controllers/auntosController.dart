import 'dart:convert';
import 'package:http/http.dart' as http;

class AutosService {
  final String baseUrl = 'https://autos-03-12.onrender.com/api/autos';  // Corrige "auntos" → "autos"

  Future<Map<String, dynamic>> registrarAuto(String marca, String modelo, String imagen, double valorAlquiler, int anio, bool disponibilidad) async {
    try {
      final url = Uri.parse('$baseUrl/');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'marca': marca,
          'modelo': modelo,
          'imagenUrl': imagen,  // Consistente con parámetro
          'valorAlquiler': valorAlquiler,
          'anio': anio,
          'disponibilidad': disponibilidad,
        }),
      );

      final data = jsonDecode(response.body);

      return {
        'success': response.statusCode == 201 || response.statusCode == 200,
        'mensaje': data['mensaje'] ?? 'Registro exitoso',
        'auto': data['auto'],
      };
    } catch (e) {
      return {
        'success': false,
        'mensaje': 'Error de conexión: $e',
      };
    }
  }
}