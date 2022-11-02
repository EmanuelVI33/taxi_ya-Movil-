import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/models/user.dart';
import 'package:taxi_ya/screens/screens.dart';
import 'package:taxi_ya/services/user_service.dart';
import 'package:taxi_ya/ui/input_decorations.dart';
import 'package:taxi_ya/widgets/widgets.dart';
import 'package:taxi_ya/constant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtNombre = TextEditingController(),
      txtApellido = TextEditingController(),
      txtTelefono = TextEditingController(),
      txtEmail = TextEditingController(),
      txtPassword = TextEditingController(),
      txtPasswordConfirm = TextEditingController(),
      txtToken = TextEditingController();
  bool loading = false;

  void _registerUser() async {
    ApiResponse response = await register(txtNombre.text, txtApellido.text,
        txtTelefono.text, txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.pushNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          // Permite hacer scroll si sus hijos sobrepasan la cantidad de tamaño
          child: Column(children: [
            const SizedBox(
              height: 250,
            ),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Crear Cuenta',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Form(
                      autovalidateMode: AutovalidateMode
                          .onUserInteraction, // Valida siempre que el usuario haga una interación
                      key: formkey, // Ya esta asocciado el key
                      child: Column(
                        children: [
                          // Nombre
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            controller: txtNombre,
                            decoration: InputDecorations.authInputDecorations(
                              labelText: 'Nombre',
                              hintText: 'ingresa tu nombre',
                              prefixIcon: Icons.account_box,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Apellido
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            controller: txtApellido,
                            decoration: InputDecorations.authInputDecorations(
                              labelText: 'Apellido',
                              hintText: 'ingresa tu apellido',
                              prefixIcon: Icons.account_box_outlined,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Telefono
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            controller: txtTelefono,
                            decoration: InputDecorations.authInputDecorations(
                              labelText: 'Teléfono',
                              hintText: 'ingresa tu número telefónico',
                              prefixIcon: Icons.phone_android_rounded,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Email
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecorations.authInputDecorations(
                              labelText: 'Correo Electronico',
                              hintText: 'example@gmail.com',
                              prefixIcon: Icons.alternate_email_outlined,
                            ),
                            controller: txtEmail,
                            validator: (value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(pattern);
                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'Formato de correo invalido';
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Password
                          TextFormField(
                            autocorrect: false,
                            obscureText: true, // Ocultar contenido
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecorations.authInputDecorations(
                              labelText: 'Contraseña',
                              hintText: '******',
                              prefixIcon: Icons.lock_outline_rounded,
                            ),
                            controller: txtPassword,
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'La contraseña de tener al menos 6 caracteres';
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                              controller: txtPasswordConfirm,
                              obscureText: true,
                              validator: (val) => val != txtPassword.text
                                  ? 'Confirm password does not match'
                                  : null,
                              decoration: InputDecorations.authInputDecorations(
                                labelText: 'Confirmar Contraseña',
                                hintText: '******',
                                prefixIcon: Icons.lock_outline_rounded,
                              )),
                          loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : kTextButton('Iniciar Seción', () {
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                      _registerUser();
                                    });
                                  }
                                }),
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            KLoginRegisterHint('¿Ya tienes una cuenta?', 'Inicia Sección', () {
              Navigator.of(context).pushNamed('login');
            }),
            const SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
    );
  }
}
