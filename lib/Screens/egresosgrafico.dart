import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class EgresosChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 184, 240),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 184, 240),
        title: const Text('Gráfico de Egresos',
            style:TextStyle(color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 24,
            fontWeight: FontWeight.bold),),
      ),
      body: EgresosChart(),
    );
  }
}

class EgresosChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('egresos').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay egresos registrados.'));
        }

        final egresosDocs = snapshot.data!.docs;

        // Procesar los datos
        Map<String, double> egresosMap = {};
        for (var doc in egresosDocs) {
          final fecha = (doc['date'] as Timestamp).toDate();
          final formattedDate = DateFormat('dd/MM/yyyy').format(fecha);
          final monto = doc['monto'] as int;

          if (egresosMap.containsKey(formattedDate)) {
            egresosMap[formattedDate] = egresosMap[formattedDate]! + monto;
          } else {
            egresosMap[formattedDate] = monto.toDouble();
          }
        }

        // Convertir los datos a un formato adecuado para el gráfico
        final sortedKeys = egresosMap.keys.toList()..sort((a, b) => DateFormat('dd/MM/yyyy').parse(a).compareTo(DateFormat('dd/MM/yyyy').parse(b)));
        List<FlSpot> dataSpots = [];
        for (var key in sortedKeys) {
          dataSpots.add(FlSpot(DateFormat('dd/MM/yyyy').parse(key).millisecondsSinceEpoch.toDouble(), egresosMap[key]!));
        }

        return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Container(
        decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(DateFormat('dd/MM').format(date)),
                  );
                },
                //interval: (dataSpots.last.x - dataSpots.first.x) / 2,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Eliminar títulos superiores
            ),
          ),
          borderData: FlBorderData(show: true), // Esconde las líneas de borde
          lineBarsData: [
            LineChartBarData(
              spots: dataSpots,
              isCurved: true, // Cambia la línea a una curva suave
              barWidth: 2, // Reduce el ancho de la barra
            
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.3), // Cambia los colores del área debajo de la barra
                    Colors.blueAccent.withOpacity(0.1),
                  ],
                ),
              ),
              aboveBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.1), // Agrega un gradiente por encima de la barra
                    Colors.blueAccent.withOpacity(0.05),
                  ],
                ),
              ),
              dotData: FlDotData(
                show: true, // Muestra los puntos
            
              ),
              shadow: Shadow(
                blurRadius: 8, // Agrega una sombra a la línea
                color: Colors.blueAccent.withOpacity(0.5),
                offset: Offset(2, 2),
              ),
            ),
          ],
        ),
      ),
        ),
      )
    );
    },
);
}
}