import 'dart:convert';
import 'package:http/http.dart' as http;

class AutosService {
  final String baseUrl = 'https://autos-03-12.onrender.com/api/auntos';

  Future<http.Response> registrarAuto(String marca, String modelo, String imagen, double valorAlquiler, int anio, bool disponibilidad) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'marca': marca,
        'modelo': modelo,
        'imagenUrl': imagen,
        'valorAlquiler': valorAlquiler,
        'anio': anio,
        'disponibilidad': disponibilidad,
      }),
    );

    return response;
  }
}
