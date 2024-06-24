import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parcial1/Screens/login.dart';
import 'package:intl/intl.dart';

class RegistrarEgreso extends StatefulWidget {
  @override
  State<RegistrarEgreso> createState() => _RegistrarEgresoState();
}

class _RegistrarEgresoState extends State<RegistrarEgreso> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _motivoController = TextEditingController();
  DateTime? _selectedDate;
  final _formatter = NumberFormat("#,##0", "es_PY");

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      return;
    }

    final monto = int.parse(_montoController.text.replaceAll('.', ''));
    final motivo = _motivoController.text;
    final fecha = _selectedDate!;

    await FirebaseFirestore.instance.collection('egresos').add({
      'monto': monto,
      'motivo': motivo,
      'date': fecha,
    });

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _formatAmount(String value) {
    if (value.isEmpty) {
      _montoController.value = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      return;
    }

    final newValue = value.replaceAll('.', '');
    final formattedValue = _formatter.format(int.parse(newValue));
    _montoController.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 105, 184, 240),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 105, 184, 240),
          title: Text(
            'Registrar Egresos',
            style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Monto',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Monto',
                          filled: true,
                          fillColor: Color.fromARGB(255, 150, 242, 225)
                              .withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        controller: _montoController,
                        keyboardType: TextInputType.number,
                        onChanged: _formatAmount,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un monto';
                          }
                          if (int.tryParse(value.replaceAll('.', '')) == null) {
                            return 'Por favor ingrese un numero valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Motivo',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Motivo',
                          filled: true,
                          fillColor: Color.fromARGB(255, 154, 242, 240)
                              .withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        controller: _motivoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un motivo';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'No se ha seleccionado una fecha'
                                : 'Fecha: ${_selectedDate!.toLocal()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: _presentDatePicker,
                          child: Text('Seleccionar Fecha'),
                        ),
                      ]),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitData,
                        child: Text('Registrar Egreso'),
                      ),
                    ],
                  ),
                ))));
  }
}
