import 'dart:convert';
import 'package:http/http.dart';
import '../../model/vacasCategorias.dart';

Future<List<Vacas>> listaVacas(path) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Response response = await get(Uri.parse(path), headers: headers);
  
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Vacas> listProducts = [];
    for (Map items in map){
      Vacas vacas = Vacas(id: items['id'], id_usuario: items['id_usuario'], nombre: items['nombre'], 
      descripcion: items['descripcion'], raza: items['raza'], num_arete: items['num_arete'],
      estado: items['estado'], fecha_llegada: items['fecha_llegada'], edad: items['edad']);
      listProducts.add(vacas);
    }
    return listProducts;
  }
  return [];
}