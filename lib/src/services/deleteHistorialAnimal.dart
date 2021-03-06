import 'dart:convert';
import 'package:http/http.dart' as http;

String host = 'medicamentos-vacoro-1752549805.us-east-1.elb.amazonaws.com';

Future<Map<String, dynamic>> servicedeletevacatoro_historial(
  String tipoAnimal,
  int id,
  String token,
) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  String loginAPI;
  if (tipoAnimal == "Vaca") {
    loginAPI = '/medicamentos_historial_vaca/delete';
  } else {
    loginAPI = '/medicamentos_historial_toro/delete';
  }

  try {
    final response = await http.post(
      Uri.http(host, loginAPI),
      headers: headers,
      body: json.encode({'id': id}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
      };
      print(responseMap);

      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}

Future<Map<String, dynamic>> servicedeletebecerro_historial(
  int id,
  String token,
) async {
  print("rntor hisi");
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  String loginAPI = '/medicamentos_historial_becerro/delete';

  try {
    final response = await http.post(
      Uri.http(host, loginAPI),
      headers: headers,
      body: json.encode({'id': id}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      Map<String, dynamic> responseMap = {
        'status': data['status'],
      };
      print(responseMap);

      return responseMap;
    } else {
      return {'status': 'Error'};
    }
  } catch (e) {
    return {'status': 'Error al conectarse con el servidor'};
  }
}
