import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class IngresosChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 217, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 229, 240),
        title: const Text(
          'Gráfico de Ingresos',
          style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: IngresosChart(),
    );
  }
}

class IngresosChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('ingresos').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay ingresos registrados.'));
        }

        final ingresosDocs = snapshot.data!.docs;

        // Procesar los datos
        Map<String, double> ingresosMap = {};
        for (var doc in ingresosDocs) {
          final fecha = (doc['date'] as Timestamp).toDate();
          final formattedDate = DateFormat('dd/MM/yyyy').format(fecha);
          final monto = doc['monto'] as int;

          if (ingresosMap.containsKey(formattedDate)) {
            ingresosMap[formattedDate] = ingresosMap[formattedDate]! + monto;
          } else {
            ingresosMap[formattedDate] = monto.toDouble();
          }
        }

        // Convertir los datos a un formato adecuado para el gráfico
        final sortedKeys = ingresosMap.keys.toList()
          ..sort((a, b) => DateFormat('dd/MM/yyyy')
              .parse(a)
              .compareTo(DateFormat('dd/MM/yyyy').parse(b)));
        List<FlSpot> dataSpots = [];
        for (var key in sortedKeys) {
          dataSpots.add(FlSpot(
              DateFormat('dd/MM/yyyy')
                  .parse(key)
                  .millisecondsSinceEpoch
                  .toDouble(),
              ingresosMap[key]!));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      DateTime date =
                          DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(DateFormat('dd/MM').format(date)),
                      );
                    },
                    interval: (dataSpots.last.x - dataSpots.first.x) / 6,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: false), // Eliminar títulos superiores
                ),
                // leftTitles: const AxisTitles(
                //   sideTitles: SideTitles(showTitles: true),
                // ),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: dataSpots,
                  isCurved: false,
                  barWidth: 3,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
