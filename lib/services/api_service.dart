import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.tu-backend.com"; // Cambia esto

  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("GET error: ${response.statusCode}");
    }
  }

  static Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("POST error: ${response.statusCode}");
    }
  }
}
