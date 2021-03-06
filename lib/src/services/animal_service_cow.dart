import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vacoro_proyect/src/pages/menu.dart';
import 'package:vacoro_proyect/src/utils/user_secure_storage.dart';

String ip = "192.168.0.2";
// String ip = '10.0.2.2';

Future<List<Map<String, dynamic>>> getAllCow(int id_usuario, token) async {
  print(id_usuario);
  try {
    final response = await http.post(
        Uri.http('animales-vacoro-729421269.us-east-1.elb.amazonaws.com',
            '/vaca/getVacaUsuario'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"id_usuario": id_usuario}));
    print('boddddddddddddddddddyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Map<String, dynamic>> listCow = [];

      if (data != null) {
        for (Map cow in data) {
          if (cow['estado'] == 1) {
            bool estado = true;
            cow['estado'] = estado;
          } else {
            bool estado = false;
            cow['estado'] = estado;
          }
          Map<String, dynamic> mapListCow = {
            'id': cow['id'],
            'url_img': cow['url_img'],
            'nombre': cow['nombre'],
            'num_arete': cow['num_arete'],
            'raza': cow['raza'],
            'estado': cow['estado']
          };
          listCow.add(mapListCow);
        }
      }
      print("?'''''''''''''''''''''''''''''''''''''''");
      print(listCow);

      return listCow;
    } else {
      print("?'''''''''''''''''''''''''''''''''''''''");
      print(response.statusCode);
      return [
        {"status": "${response.statusCode}"},
        {"message": "No se puede conectar al servidor :("}
      ];
    }
  } catch (e) {
    print("?'''''''''''''''''''''''''''''''''''''''");
    print(e);
    return [
      {"error": "error"}
    ];
  }
}
