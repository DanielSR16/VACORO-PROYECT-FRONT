import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> serviceanadirvacatoro(
  String tipoAnimal,
  String nombre,
  String descripcion,
  String raza,
  String num_arete,
  String url_img,
  int estado,
  int edad,
  String fecha_llegada,
) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  String animalAPI;
  if (tipoAnimal == "Vaca") {
    animalAPI = '/vaca/new/';
  } else {
    animalAPI = '/toro/new/';
  }
  print(animalAPI);
  String host = '192.168.0.5:3001';
  int id_usuario = 0;
  try {
    final response = await http.post(
      Uri.http(host, animalAPI),
      headers: headers,
      body: json.encode(
        {
          'id_usuario': id_usuario,
          'nombre': nombre,
          'descripcion': descripcion,
          'raza': raza,
          'num_arete': num_arete,
          'url_img': url_img,
          'estado': estado,
          'edad': edad,
          'fecha_llegada': fecha_llegada
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
      };
      return responseMap;
      //return 'ok';
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}
