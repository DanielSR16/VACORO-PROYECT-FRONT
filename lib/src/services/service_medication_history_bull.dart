import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.0.2";

Future getMedicationHistoryByIdCowBull(int id_animal) async {
  try {
    final response = await http.post(
        Uri.http("medicamentos-vacoro-1752549805.us-east-1.elb.amazonaws.com",
            "/medicamentos_historial_toro/getAnimalHistorialBull"),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({"id_animal": id_animal}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data);
      return data;
    } else {
      return "No se pudo conectar al servidor :(\n Codigo de error: ${response.statusCode}";
    }
  } catch (e) {
    return "Error: $e";
  }
}
