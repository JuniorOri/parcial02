import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'INICIO',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Times New Roman',
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 29, 115, 186),
      ),
      backgroundColor: Color.fromARGB(255, 55, 148, 201),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 188, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'ingresos');
                        },
                        child: const Text(
                          'Registrar Ingreso',
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 188, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'egresos');
                        },
                        child: const Text(
                          'Registrar Egreso',
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 188, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'listaIngresos');
                        },
                        child: const Text(
                          'HIstorial de Ingresos',
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 188, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'listaEgresos');
                        },
                        child: const Text(
                          'Historial de Egresos',
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 188, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'ingresosgrafico');
                        },
                        child: const Text(
                          'Gráfico de Ingresos',
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 188, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'egresosgrafico');
                        },
                        child: const Text(
                          'Gráfico de Egresos',
                          style: TextStyle(fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const HomeScreen(),
    routes: {
      'ingresos': (context) => Container(color: Colors.green),
      'egresos': (context) => Container(color: Colors.red),
      'listaIngresos': (context) => Container(color: Colors.blue),
      'listaEgresos': (context) => Container(color: Colors.orange),
      'ingresosgrafico': (context) => Container(color: Colors.yellow),
      'egresosgrafico': (context) => Container(color: Colors.purple),
    },
  ));
}
