import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vacoro_proyect/src/style/colors/colorview.dart';
import 'package:vacoro_proyect/src/pages/reportes.dart';
import 'editarPerfilContrasena.dart';
import 'editar_perfil.dart';

List data = [];
Drawer drawer(BuildContext context, nombre, correo, imageUsuario, id_usuario) {
  data.add(nombre);
  data.add(correo);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
            color: ColorSelect.color5,
          ),
          accountName: RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.person,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "Nombre " + nombre,
                ),
              ],
            ),
          ),
          accountEmail: RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.email,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: " Correo electrónico " + correo,
                ),
              ],
            ),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(imageUsuario),
          ),
        ),
        ListTile(
          title: const Text('Ver vacas'),
          onTap: () {
            Navigator.pushNamed(context, "dash_cow", arguments: data);
          },
          leading: const Image(
            image: AssetImage('assets/images/vaca.png'),
            width: 30,
          ),
        ),
        ListTile(
          title: const Text('Ver toros'),
          onTap: () {
            Navigator.pushNamed(context, "dash_bull", arguments: data);
          },
          leading: const Image(
            image: AssetImage('assets/images/toro.png'),
            width: 30,
          ),
        ),
        ListTile(
          title: const Text('Ver becerros'),
          onTap: () {
            Navigator.pushNamed(context, "dash_calf", arguments: data);
          },
          leading: const Image(
            image: AssetImage('assets/images/becerro.png'),
            width: 30,
          ),
        ),
        ListTile(
          title: const Text('Agregar medicamentos'),
          onTap: () {
            Navigator.pushNamed(context, 'dash_medication');
          },
          leading: const Image(
            image: AssetImage('assets/images/Icon_syringe.png'),
            width: 40,
          ),
        ),
        ListTile(
          title: const Text('Agregar categorias'),
          onTap: () {
            Navigator.pushNamed(context, 'dash_category');
          },
          leading: const Image(
            image: AssetImage('assets/images/Icon_Carpeta.png'),
            width: 27,
          ),
        ),
        ListTile(
          title: const Text('Generar reporte'),
          onTap: () {
            Navigator.pushNamed(context, 'reportes');
          },
          leading: const Image(
            image: AssetImage('assets/images/Icon_Report.png'),
            width: 30,
          ),
        ),
        const Divider(
          height: 5,
          thickness: 2,
          color: ColorSelect.color1,
        ),
        ListTile(
          title: const Text('Editar perfil'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => EditarPerfil(
                  id_usuario: id_usuario,
                ),
              ),
            );
          },
          leading: const Image(
            image: AssetImage('assets/images/Icon_settings.png'),
            width: 35,
          ),
        ),
        ListTile(
          title: const Text('Cambiar contraseña'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => EditarContrasena(
                  id_usuario: id_usuario,
                ),
              ),
            );
          },
          leading: const Image(
            image: AssetImage('assets/images/icon_password.png'),
            width: 35,
          ),
        ),
        ListTile(
          title: const Text('Cerrar sesión'),
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'pre_login', (Route<dynamic> route) => false);
          },
          leading: const Image(
            image: AssetImage('assets/images/Icon_salida.png'),
            width: 25,
          ),
        ),
      ],
    ),
  );
}

// Future downloadFile(url, filename) async {
//   bool downloading = true;
//   String downloadingStr = "No data";

//   final directory = await getExternalStorageDirectory();
//   String rutaGuardado = directory!.path + "/";

//   try {
//     Dio dio = Dio();
//     var savePath = await getFilePath(rutaGuardado, filename);
//     await dio.download(url, savePath, onReceiveProgress: (rec, total) {
//       downloading = true;
//       downloadingStr = "Downloading Image : $rec";
//     });

//     downloading = false;
//     downloadingStr = "Completed";

//     print(downloading);
//   } catch (e) {
//     print(e.toString());
//   }
// }

// Future<String> getFilePath(rutaGuardado, fileName) async {
//   String path = 'storage/emulated/0/download' + fileName;
//   return path;
// }
