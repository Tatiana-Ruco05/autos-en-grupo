// lib/controllers/clientesController.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientesService {
  static const String baseUrl = 'https://autos-03-12.onrender.com/api/clientes';

  Future<Map<String, dynamic>> resgistrarCliente(
    String nombre,
    String correo,
    String numLic,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nombre': nombre,
              'correo': correo,
              'numLic': numLic,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 30));

      final data = jsonDecode(response.body);

      return {
        'success': response.statusCode == 201 || response.statusCode == 200,
        'mensaje': data['mensaje'] ?? 'Registro exitoso',
        'cliente': data['cliente'],
      };
    } catch (e) {
      return {
        'success': false,
        'mensaje': 'Error de conexión: $e',
      };
    }
  }

 
  Future<Map<String, dynamic>> loginCliente(
      String correo, String password) async {
    try {
      print('Intentando login con: $correo');

      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'correo': correo,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 30));

      print('Status: ${response.statusCode}');
      print('Respuesta: ${response.body}');

      final data = jsonDecode(response.body);

      // Tu backend responde con "mensaje": "Login exitoso"
      if (response.statusCode == 200 && data['mensaje'] == 'Login exitoso') {
        return {
          'success': true,
          'cliente': data['cliente'],
          'token': data['token'], // útil para más adelante
          'mensaje': data['mensaje'],
        };
      } else {
        return {
          'success': false,
          'mensaje': data['mensaje'] ?? 'Credenciales inválidas',
        };
      }
    } catch (e) {
      print('Error en login: $e');
      return {
        'success': false,
        'mensaje': 'Error de conexión',
      };
    }
  }
}
