import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.0.31";
// String ip = "10.0.2.2";

Future<List<Map<String, dynamic>>> getAllCalf() async {
  try {
    final response = await http.get(
      Uri.http(ip + ":3001", "/becerro/all"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Map<String, dynamic>> listCalf = [];

      if (data != null) {
        for (Map calf in data) {
          // if (calf['id_usuario'] == 1) {
          if (calf['estado'] == 1) {
            calf['estado'] = true;
          } else {
            calf['estado'] = false;
          }

          Map<String, dynamic> mapListCalf = {
            'id': calf['id'],
            'url_img': calf['url_img'],
            'nombre': calf['nombre'],
            'num_arete': calf['num_arete'],
            'raza': calf['raza'],
            'estado': calf['estado']
          };
          listCalf.add(mapListCalf);
          // }
        }
      }
      // print(listCalf);
      return listCalf;
    } else {
      return [
        {"status": "${response.statusCode}"},
        {"message": "No se puede conectar al servidor"}
      ];
    }
  } catch (e) {
    return [
      {"error": "Error: $e"}
    ];
  }
}