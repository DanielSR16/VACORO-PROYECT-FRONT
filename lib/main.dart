import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vacoro_proyect/src/pages/add_categories.dart';
import 'package:vacoro_proyect/src/pages/anadir_becerro.dart';

import 'package:vacoro_proyect/src/pages/anadir_medicamento_animal.dart';
import 'package:vacoro_proyect/src/pages/edit_categories.dart';
import 'package:vacoro_proyect/src/pages/editar_medicamento_animal.dart';
import 'package:vacoro_proyect/src/pages/login.dart';
import 'package:vacoro_proyect/src/pages/medication.dart';
import 'package:vacoro_proyect/src/pages/dashboard_category.dart';
import 'package:vacoro_proyect/src/pages/pre_login.dart';
import 'package:vacoro_proyect/src/pages/registro_user.dart';
import 'package:vacoro_proyect/src/pages/registro_user2.dart';
import 'package:vacoro_proyect/src/pages/reportes.dart';

import 'package:vacoro_proyect/src/pages/vista_principal.dart';

import 'package:vacoro_proyect/src/pages/registro_user.dart';
import 'package:vacoro_proyect/src/pages/registro_user2.dart';
import 'package:vacoro_proyect/src/pages/vista_principal.dart';

import 'package:vacoro_proyect/src/pages/anadir_animal.dart';

import 'package:vacoro_proyect/src/pages/dashboard_bull.dart';
import 'package:vacoro_proyect/src/pages/dashboard_calf.dart';
import 'package:vacoro_proyect/src/pages/dashboard_cow.dart';
import 'package:vacoro_proyect/src/pages/splash.dart';
import 'package:vacoro_proyect/src/pages/splash_canva.dart';
import 'package:vacoro_proyect/src/widgets/window_modal/modal_cow_calf_details.dart'; // import 'package:vacoro_proyect/src/pages/vista_principal.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VACORO',
        initialRoute: 'splash',
        routes: {
          // 'autenticacion': (BuildContext context) => const autenticacion(),
          // 'homePage': (BuildContext context) => homePage(),
          // 'vistaPrincipal': (BuildContext context) => const vista_principal(),
          'anadir_categoria': (BuildContext context) => addCategories(),
          'editar_categoria': (BuildContext context) => editCategories(),
          'AnadirBecerro': (BuildContext context) => AnadirBecerro(),
          'splash': (BuildContext context) => Splash(),
          'splash_canva': (BuildContext context) => SplashCanva(),
          'login': (BuildContext context) => const Login(),
          'pre_login': (BuildContext context) => const preLogin(),
          'dash_cow': (BuildContext context) => DashBoardCow(),
          'dash_bull': (BuildContext context) => DashBoardBull(),
          'dash_calf': (BuildContext context) => DashBoardCalf(),
          'dash_category': (BuildContext context) => DashboardCategory(),
          'registroUser': (BuildContext context) => registroUser(),
          'registroUser2': (BuildContext context) => registroUser2(),
          'medication': (BuildContext context) => Medication(),
          'reportes': (BuildContext context) => generateReports(),
          // 'medication_history': (BuildContext context) => MedicationHistory(),
          'dash_medication': (BuildContext context) => Medication(),
          'AnadirMedicamentoAnimal': (BuildContext context) =>
              AnadirMedicamentoAnimal(),
        });
  }
}
