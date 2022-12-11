import 'package:flutter/material.dart';
import 'package:taxi_ya/models/models.dart';
import 'package:taxi_ya/providers/providers.dart';
import 'package:taxi_ya/providers/register_form_provider.dart';
import 'package:taxi_ya/services/auth_service.dart';
import 'package:taxi_ya/ui/input_decorations.dart';
import 'package:taxi_ya/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(height: 10),
              Text('Crear cuenta',
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 30),
              ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(), child: _LoginForm())
            ],
          )),
          const SizedBox(height: 50),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: const Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              )),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<RegisterFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // Nombre
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecorations(
                hintText: 'nombre',
                labelText: 'Nombre',
                prefixIcon: Icons.person),
            onChanged: (value) => loginForm.nombre = value,
            validator: (value) {},
          ),
          const SizedBox(height: 30),
          // Apellido
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecorations(
                hintText: 'ingresa tu apellido',
                labelText: 'Apellido',
                prefixIcon: Icons.person_outline_outlined),
            onChanged: (value) => loginForm.apellido = value,
            validator: (value) {},
          ),
          const SizedBox(height: 30),
          // Telefono
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecorations.authInputDecorations(
                hintText: 'ingresa tu número de celular',
                labelText: 'Teléfono',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.telefono = value,
          ),
          const SizedBox(height: 30),
          // Email
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecorations(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecorations(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecorations(
                hintText: '*****',
                labelText: 'Confirmar contraseña',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.passwordConfirmation = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? (loginForm.password != loginForm.passwordConfirmation)
                      ? 'No coinciden las contraseña'
                      : null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
          ),
          const SizedBox(height: 30),

          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final ApiResponse response = await authService.register(
                          loginForm.nombre,
                          loginForm.apellido,
                          loginForm.telefono,
                          loginForm.email,
                          loginForm.password,
                          loginForm.passwordConfirmation);

                      final user = response.data as User;

                      if (response.error == null) {
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);

                        userProvider.id = user.id;
                        userProvider.nombre = user.nombre;
                        userProvider.apellido = user.apellido;
                        userProvider.email = user.email;
                        userProvider.telefono = user.telefono;
                        userProvider.image = user.image;
                        userProvider.token = user.token;

                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        // NotificationsService.showSnackbar(errorMessage);
                        loginForm.isLoading = false;
                      }
                    },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: const TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }
}

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   TextEditingController txtNombre = TextEditingController(),
//       txtApellido = TextEditingController(),
//       txtTelefono = TextEditingController(),
//       txtEmail = TextEditingController(),
//       txtPassword = TextEditingController(),
//       txtPasswordConfirm = TextEditingController(),
//       txtToken = TextEditingController();
//   bool loading = false;

  // void _registerUser() async {
  //   ApiResponse response = await register(txtNombre.text, txtApellido.text,
  //       txtTelefono.text, txtEmail.text, txtPassword.text);
  //   if (response.error == null) {
  //     _saveAndRedirectToHome(response.data as User);
  //   } else {
  //     setState(() {
  //       loading = false;
  //     });
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('${response.error}')));
  //   }
  // }

  // void _saveAndRedirectToHome(User user) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString('token', user.token ?? '');
  //   await pref.setInt('userId', user.id ?? 0);
  //   Navigator.pushNamed(context, 'home');
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AuthBackground(
//         child: SingleChildScrollView(
//           // Permite hacer scroll si sus hijos sobrepasan la cantidad de tamaño
//           child: Column(children: [
//             const SizedBox(
//               height: 250,
//             ),
//             CardContainer(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   Text(
//                     'Crear Cuenta',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   const SizedBox(height: 10),
//                   Form(
//                       autovalidateMode: AutovalidateMode
//                           .onUserInteraction, // Valida siempre que el usuario haga una interación
//                       key: formkey, // Ya esta asocciado el key
//                       child: Column(
//                         children: [
//                           // Nombre
//                           TextFormField(
//                             autocorrect: false,
//                             keyboardType: TextInputType.text,
//                             controller: txtNombre,
//                             decoration: InputDecorations.authInputDecorations(
//                               labelText: 'Nombre',
//                               hintText: 'ingresa tu nombre',
//                               prefixIcon: Icons.account_box,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           // Apellido
//                           TextFormField(
//                             autocorrect: false,
//                             keyboardType: TextInputType.text,
//                             controller: txtApellido,
//                             decoration: InputDecorations.authInputDecorations(
//                               labelText: 'Apellido',
//                               hintText: 'ingresa tu apellido',
//                               prefixIcon: Icons.account_box_outlined,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           // Telefono
//                           TextFormField(
//                             autocorrect: false,
//                             keyboardType: TextInputType.number,
//                             controller: txtTelefono,
//                             decoration: InputDecorations.authInputDecorations(
//                               labelText: 'Teléfono',
//                               hintText: 'ingresa tu número telefónico',
//                               prefixIcon: Icons.phone_android_rounded,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           // Email
//                           TextFormField(
//                             autocorrect: false,
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecorations.authInputDecorations(
//                               labelText: 'Correo Electronico',
//                               hintText: 'example@gmail.com',
//                               prefixIcon: Icons.alternate_email_outlined,
//                             ),
//                             controller: txtEmail,
//                             validator: (value) {
//                               String pattern =
//                                   r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                               RegExp regExp = RegExp(pattern);
//                               return regExp.hasMatch(value ?? '')
//                                   ? null
//                                   : 'Formato de correo invalido';
//                             },
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           // Password
//                           TextFormField(
//                             autocorrect: false,
//                             obscureText: true, // Ocultar contenido
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecorations.authInputDecorations(
//                               labelText: 'Contraseña',
//                               hintText: '******',
//                               prefixIcon: Icons.lock_outline_rounded,
//                             ),
//                             controller: txtPassword,
//                             validator: (value) {
//                               return (value != null && value.length >= 6)
//                                   ? null
//                                   : 'La contraseña de tener al menos 6 caracteres';
//                             },
//                           ),
//                           const SizedBox(
//                             height: 30,
//                           ),
//                           TextFormField(
//                               controller: txtPasswordConfirm,
//                               obscureText: true,
//                               validator: (val) => val != txtPassword.text
//                                   ? 'Confirm password does not match'
//                                   : null,
//                               decoration: InputDecorations.authInputDecorations(
//                                 labelText: 'Confirmar Contraseña',
//                                 hintText: '******',
//                                 prefixIcon: Icons.lock_outline_rounded,
//                               )),
//                           loading
//                               ? const Center(
//                                   child: CircularProgressIndicator(),
//                                 )
//                               : kTextButton('Iniciar Seción', () {
//                                   if (formkey.currentState!.validate()) {
//                                     setState(() {
//                                       loading = true;
//                                       // _registerUser();
//                                     });
//                                   }
//                                 }),
//                         ],
//                       )),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             KLoginRegisterHint('¿Ya tienes una cuenta?', 'Inicia Sección', () {
//               Navigator.of(context).pushNamed('login');
//             }),
//             const SizedBox(
//               height: 50,
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
