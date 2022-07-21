import 'dart:convert';

import 'package:http/http.dart' as http;

String ip = "192.168.56.1";
// String ip = "10.0.2.2";

Future<List<Map<String, dynamic>>> getAllBull(int id_usuario) async {
  print(id_usuario);
  try {
    final response = await http.post(
        Uri.http(ip + ":3001", "/toro/getTorosUsuario"),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({'id_usuario': id_usuario}));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      List<Map<String, dynamic>> listBull = [];

      if (data != null) {
        for (Map bull in data) {
          // if(bull['id_usuario'] == 1){
          if (bull['estado'] == 1) {
            bull['estado'] = true;
          } else {
            bull['estado'] = false;
          }

          Map<String, dynamic> mapListBull = {
            'id': bull['id'],
            'url_img': bull['url_img'],
            'nombre': bull['nombre'],
            'num_arete': bull['num_arete'],
            'raza': bull['raza'],
            'estado': bull['estado']
          };
          listBull.add(mapListBull);
          // }
        }
      }
      // print(listBull);
      return listBull;
    } else {
      print(response.statusCode);
      return [
        {"status": "${response.statusCode}"},
        {"message": "No se puede conectar al servidor :("}
      ];
    }
  } catch (e) {
    print(e);
    return [
      {"error": "Error: $e"}
    ];
  }
}
