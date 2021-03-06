import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vacoro_proyect/src/model/categorias.dart';

import '../../pages/edit_categories_complete.dart';

Future<List<Categoria>> listaCategorias(path) async {
  Map<String, String> headers = {'Content-Type': 'application/json'};
  Response response = await get(Uri.parse(path), headers: headers);

  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<Categoria> listProducts = [];
    for (Map items in map) {
      Categoria categoria = Categoria(
          idCategoria: items['id'],
          nombreCategoria: items['nombre'],
          descripcionCategoria: items['descripcion']);
      listProducts.add(categoria);
    }
    return listProducts;
  }
  return [];
}

Future<List<dynamic>> listaAnimalesByIdCategoria(path, id) async {
  var cuerpo = jsonEncode({"id_categoria": id});
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final map = json.decode(response.body);
    List<dynamic> listProducts = [];
    for (Map items in map) {
      listProducts.add(items);
    }
    return listProducts;
  }
  return [];
}

Future listaPeticiones(cuerpoCategoria, listaAnimales) async {
  var nombre = await addCategoria(
      'http://user-vacoro-1804981318.us-east-1.elb.amazonaws.com/categoria/createCategoria',
      cuerpoCategoria);
  Future.delayed(Duration(milliseconds: 2000), () {
    findNameCategory(
        "http://user-vacoro-1804981318.us-east-1.elb.amazonaws.com/categoria/findCategoryByName",
        nombre,
        listaAnimales);
  });
}

Future addCategoria(path, cuerpo) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: cuerpo);
  if (response.statusCode == 200) {
    final respuestaJson = json.decode(response.body);
    //var body = jsonEncode({"nombre": res
    //puestaJson['nombre']});
    return respuestaJson;
  } else {
    return 'no se creo';
  }
}

Future findNameCategory(path, nombre, listaAnimales) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  List listaVaca = [];
  List listaToro = [];
  List listaBecerro = [];
  Response response =
      await post(Uri.parse(path), headers: headers, body: nombre);
  if (response.statusCode == 200) {
    var map = json.decode(response.body);
    var idCategoria = map['id'];
    for (var i in listaAnimales) {
      if (i.containsKey("idVaca")) {
        //{"id_toro": 2,"id_categoria": 1}
        var cuerpo = jsonEncode({
          "id_vaca": i['idVaca'],
          "id_categoria": idCategoria
        }); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
        listaVaca.add(cuerpo);
      }
      if (i.containsKey("idToro")) {
        //{"id_toro": 2,"id_categoria": 1}
        var cuerpo = jsonEncode({
          "id_toro": i['idToro'],
          "id_categoria": idCategoria
        }); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
        listaToro.add(cuerpo);
      }
      if (i.containsKey("idBecerro")) {
        //{"id_toro": 2,"id_categoria": 1}
        var cuerpo = jsonEncode({
          "id_becerro": i['idBecerro'],
          "id_categoria": idCategoria
        }); //"id_vaca": null,"id_toro": null,"id_becerro": null,"id_categoria": 3
        listaBecerro.add(cuerpo);
      }
    }

    if (listaVaca.length > 0) {
      print(listaVaca);
      var x = await createAnimalCategory(
          "http://user-vacoro-1804981318.us-east-1.elb.amazonaws.com/categoria/createCategoryVaca",
          listaVaca.toString());
    }
    if (listaToro.length > 0) {
      print(listaToro);
      var x = await createAnimalCategory(
          "http://user-vacoro-1804981318.us-east-1.elb.amazonaws.com/categoria/createCategoryToro",
          listaToro.toString());
    }
    if (listaBecerro.length > 0) {
      print(listaBecerro);
      var x = await createAnimalCategory(
          "http://user-vacoro-1804981318.us-east-1.elb.amazonaws.com/categoria/createCategoryBecerro",
          listaBecerro.toString());
    }
  } else {
    print("no se agrego vaca animal a la categoria");
  }
}

Future createAnimalCategory(path, listaAnimal) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: listaAnimal);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    return 'no se creo';
  }
}

seleccionCategoria(listaCategorias) {
  var descripcion;
  List<String> dropdownCategoriaNombre = [];
  return Container(
    child: FutureBuilder(
        future: listaCategorias,
        builder: (context, AsyncSnapshot<List<Categoria>> snapshot) {
          if (snapshot.data != null) {
            for (int i = 0; i < snapshot.data!.length; i++) {
              dropdownCategoriaNombre.add(snapshot.data![i].nombreCategoria);
            }
            return DropdownSearch<String>(
              mode: Mode.DIALOG,
              showSearchBox: true,
              showSelectedItem: true,
              hint: "Seleccione una categoria",
              items: dropdownCategoriaNombre,
              label: "Categoria",
              onChanged: ((value) => {
                    // for (int i=0; i<snapshot.data!.length; i++){
                    //   if (value!.compareTo(snapshot.data![i].nombreCategoria) == 0){
                    //     descripcion = snapshot.data![i].descripcionCategoria,
                    //     Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: editCategoriesComplete(categoriaSeleccionada: snapshot.data![i]))),
                    //   },
                    // },
                  }),
            );
          }
          return Container();
        }),
  );
}

Future AccionarCategoria_edito_elimino(path, listaAnimal) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
  Response response =
      await post(Uri.parse(path), headers: headers, body: listaAnimal);
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    return 'no se creo';
  }
}
