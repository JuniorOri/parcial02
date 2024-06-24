import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parcial1/Screens/login.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();

  //instanciar con firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  //

  //Crear la funcion para el registro
  Future<void> _registro() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);
      // Si el registro es exitoso, inicia sesion
      Navigator.pushNamed(context, 'home');
    } catch (e) {
      // Si el registro no es correcto
      print('Error al registrarse: $e');
    }
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 184, 240),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: Column(
            children: [
              Text(
                'Registrar Nuevo Usuario',
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Estas a un paso de crear tu cuenta',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 41, 158, 216)),
                            ),
                          ),
                          // TextFormField(
                          //   autofocus: true,
                          //   textCapitalization: TextCapitalization.words,
                          //   initialValue: '',
                          //   onChanged: (value) {
                          //     print('value: $value');

                          //   },

                          //   style: TextStyle(
                          //     color: Colors.black.withOpacity(0.5), // Set opacity to 0.5
                          //    ),
                          //     decoration: InputDecoration(
                          //     hintText: 'Juan Perez',
                          //     filled: true,
                          //     fillColor: Colors.green.withOpacity(0.2),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(20),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //     contentPadding: EdgeInsets.all(10),
                          //   ),
                          // ),
                          SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Correo Electronico',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 70, 214, 222)),
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            // initialValue: '',

                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            decoration: InputDecoration(
                              hintText: 'example@example.com',
                              filled: true,
                              fillColor: Color.fromARGB(255, 59, 173, 173)
                                  .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     'Numero',
                          //     style: TextStyle(color: Colors.green),
                          //   ),

                          // ),
                          // TextFormField(
                          //   initialValue: '',

                          //   style: TextStyle(
                          //     color: Colors.black.withOpacity(0.5),
                          //    ),
                          //     decoration: InputDecoration(
                          //     hintText: '+ 595 971 456 789',
                          //     filled: true,
                          //     fillColor: Colors.green.withOpacity(0.2),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(20),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //     contentPadding: EdgeInsets.all(10),
                          //   ),
                          //),
                          SizedBox(height: 20),

                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     'Fecha De Nacimiento',
                          //     style: TextStyle(color: Colors.green),
                          //   ),

                          // ),
                          // TextFormField(
                          //   initialValue: '',

                          //   style: TextStyle(
                          //     color: Colors.black.withOpacity(0.5),
                          //    ),
                          //     decoration: InputDecoration(
                          //     hintText: 'DD / MM / YYY',
                          //     filled: true,
                          //     fillColor: Colors.green.withOpacity(0.2),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(20),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //     contentPadding: EdgeInsets.all(10),
                          //   ),
                          // ),
                          SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Contraseña',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 76, 175, 163)),
                            ),
                          ),
                          TextFormField(
                            controller: _passController,
                            //initialValue: '',
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.remove_red_eye),
                              hintText: '*************',
                              filled: true,
                              fillColor: Color.fromARGB(255, 63, 151, 145)
                                  .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),

                          //  Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     'Confirmar Contraseña',
                          //     style: TextStyle(color: Colors.green),
                          //   ),
                          // ),
                          // TextFormField(
                          //   initialValue: '',
                          //   decoration: InputDecoration(
                          //     suffixIcon: Icon(Icons.remove_red_eye),
                          //     hintText: '*************',
                          //     filled: true,
                          //     fillColor: Colors.green.withOpacity(0.2),
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(20),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //     contentPadding: EdgeInsets.all(10),
                          //   ),
                          //   obscureText: true,
                          // ),
                          const SizedBox(height: 20),

                          Text('Al continuar, usted acepta los'),
                          const Text(
                            'Términos y Condiciones',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 70, 195, 187)),
                            onPressed: _registro, //{
                            //Navigator.push(
                            //context,
                            //MaterialPageRoute(builder: (context) => LoginScreen()),
                            //);

                            //},
                            child: Text('Registrarme',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 10),
                          const Text('Ya tienes una cuenta?  Inicia sesión')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
