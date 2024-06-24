import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class EgresosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 184, 240),
        title: const Text(
          'Lista de Egresos',
          style:TextStyle(color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
          ),
      ),
      backgroundColor: const Color.fromARGB(255, 105, 184, 240),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: EgresosList(),
      ),
    );
  }
}

class EgresosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

        return ListView.builder(
          itemCount: egresosDocs.length,
          itemBuilder: (context, index) {
            final egreso = egresosDocs[index];
            final monto = egreso['monto'];
            final motivo = egreso['motivo'];
            final fecha = (egreso['date'] as Timestamp).toDate();
            final formattedDate = DateFormat('dd/MM/yyyy').format(fecha);

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.red),
                title: Text('Monto: ${NumberFormat.currency(symbol: '', decimalDigits: 0, locale: 'es_PY').format(monto)} Gs.'),
                subtitle: Text('Motivo: $motivo\nFecha: $formattedDate'),
              ),
            );
          },
        );
      },
    );
  }
}