

import 'package:firebase_core/firebase_core.dart';
import 'package:parcial1/Screens/egresos.dart';
import 'package:parcial1/Screens/egresosgrafico.dart';
import 'package:parcial1/Screens/home.dart';
import 'package:parcial1/Screens/ingresos.dart';
import 'package:parcial1/Screens/ingresosgrafico.dart';
import 'package:parcial1/Screens/list_egresos_screen.dart';
import 'package:parcial1/Screens/list_ingresos_screen.dart';
import 'package:parcial1/Screens/login.dart';
import 'package:parcial1/Screens/registro.dart';




import 'package:flutter/material.dart';
import 'package:parcial1/firebase_options.dart';

Future<void> main() async {
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MaterialApp(
    home: PrimeraApp(),
    debugShowCheckedModeBanner: false,
  ));
  
}

class PrimeraApp extends StatefulWidget {
  const PrimeraApp({super.key});

  @override
  State<PrimeraApp> createState() => _PrimeraAppState();
}

class _PrimeraAppState extends State<PrimeraApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: 'login',
      routes: <String, WidgetBuilder>{
        'login' : (_) => const LoginScreen(),
        'home' : (_) =>  const HomeScreen(),
        'egresos' : (_) => RegistrarEgreso(),
        'ingresos' : (_) => RegistrarIngresos(),
        'registro' : (_) => const RegistroScreen(),
        'listaEgresos' : (_) => EgresosScreen(),
        'listaIngresos' : (_) => IngresosScreen(),
        'egresosgrafico' : (_) => EgresosChartScreen(),
        'ingresosgrafico' : (_) => IngresosChartScreen()

        
      },
    );
  }
}