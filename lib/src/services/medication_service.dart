import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.0.31";

Future getMedicationAll(id_usuario, token) async {
  print(id_usuario);
  String d = 'Bearer ' + token;
  print(d.runtimeType);
  try {
    final response = await http.post(
        Uri.http(ip + ":3004", "/medicamento/allMedicamentosbyUser"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: json.encode({"id_usuario": id_usuario}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);

      return data;
    } else {
      return "No se pudo conectar al servidor :(\n Codigo de error: ${response.statusCode}";
    }
  } catch (e) {
    return "Error: $e";
  }
}
