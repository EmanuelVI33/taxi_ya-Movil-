import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_ya/models/api_response.dart';
import 'package:taxi_ya/models/user.dart';
import 'package:taxi_ya/screens/home_screen.dart';
import 'package:taxi_ya/screens/user/user_screen.dart';
import 'package:taxi_ya/services/user_service.dart';
import 'package:taxi_ya/ui/input_decorations.dart';
import 'package:taxi_ya/widgets/widgets.dart';
import 'package:taxi_ya/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
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

    // ignore: use_build_context_synchronously
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                    'Iniciar Sección',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Form(
                      autovalidateMode: AutovalidateMode
                          .onUserInteraction, // Valida siempre que el usuario haga una interación
                      key: formkey, // Ya esta asocciado el key
                      child: Column(
                        children: [
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
                          loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : kTextButton('Iniciar Seción', () {
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                      _loginUser();
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
            KLoginRegisterHint('No tienes una cuenta?', 'Registrate', () {
              Navigator.of(context).pushNamed('register');
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
