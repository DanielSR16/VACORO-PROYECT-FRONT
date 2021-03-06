import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.0.2";
// String ip = "10.0.2.2";

Future<List<Map<String, dynamic>>> getAllCalf(int id_usuario, token) async {
  try {
    final response = await http.post(
      Uri.http("animales-vacoro-729421269.us-east-1.elb.amazonaws.com",
          "/becerro/getBecerrosUsuario"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        "id_usuario": id_usuario,
      }),
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
      print(listCalf);
      return listCalf;
    } else {
      print(response.statusCode);
      return [
        {"status": "${response.statusCode}"},
        {"message": "No se puede conectar al servidor"}
      ];
    }
  } catch (e) {
    return [
      {"error": "error"}
    ];
  }
}
