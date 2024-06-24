import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parcial1/Screens/registro.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
//instanciar con firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  //

  //Crear la funcion para el registro
  Future<void> _inicio() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
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
      backgroundColor: Color.fromARGB(255, 40, 154, 192),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Bienvenido',
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(222, 133, 227, 237),
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
                          'Correo',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 76, 175, 175)),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'example@example.com',
                          filled: true,
                          fillColor: Color.fromARGB(255, 52, 131, 167)
                              .withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Contraseña',
                          style: TextStyle(
                              color: Color.fromARGB(215, 49, 142, 193)),
                        ),
                      ),
                      TextFormField(
                        controller: _passController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye),
                          hintText: '*************',
                          filled: true,
                          fillColor: Color.fromARGB(255, 65, 153, 184)
                              .withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 83, 175, 208)),
                        onPressed: _inicio,
                        child: Text('Iniciar Sesión'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          print('Olvidaste tu contraseña?');
                        },
                        child: Text('Olvidaste tu contraseña?'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistroScreen()),
                          );
                        },
                        child: Text('Registrarse'),
                      ),
                      // Text(' '),
                      //Text('or sign up with'),
                      Center(
                          // child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          //  children: [
                          //    Icon(Icons.facebook_rounded),
                          //  SizedBox(
                          //     width:
                          //         10), // Agrega un espacio entre los iconos
                          // Icon(Icons.g_mobiledata_rounded),
                          //  ],
                          //   ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
