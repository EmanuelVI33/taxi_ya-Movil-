import 'package:flutter/material.dart';

// Strings URL
// const baseUrl = 'https://julicosuarez.ga';  // Proyecto Desplegado
const String url = 'http://192.168.0.104:80';
const String baseUrl = '$url/api'; // Proyecto local, el host es su direcció ip
const String loginUrl = '$baseUrl/login';
const String registerUrl = '$baseUrl/register';
const String logoutUrl = "$baseUrl/logout";
const String userUrl = "$baseUrl/user";
const String userDetailUrl = "$baseUrl/user-detail";
const String solicitud = "$baseUrl/solicitud";
const String solicitudEnvio = "$solicitud/envio";

// Errores
const somethingWentWrong = 'Ha occurido un error, de nuevo';
const serverError = 'Error en el Servidor';
const unauthorized = 'No Autorizado';

void displayDialog(BuildContext context, String titulo, String content,
    String message, String route, IconData icon) {
  showDialog(
    // barrierDismissible:
    //     true, // Para que se desactiva al presionar fuera del dialogo
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15)),
        title: Text(titulo),
        content: Column(
            mainAxisSize: MainAxisSize.min, // Se adapta al tamaño de los hijos
            children: [
              Text(content),
              const SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 50,
              ),
            ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, route),
            child: Text(message),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      );
    },
  );
}

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

SizedBox kTextButton(String label, Function onPressed) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.indigo),
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.symmetric(vertical: 10))),
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Row KLoginRegisterHint(String text, String label, Function onTab) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Text(
          label,
          style: const TextStyle(color: Colors.blue, fontSize: 22),
        ),
        onTap: () => onTab(),
      )
    ],
  );
}

Widget myText(String texto, double size, Color color, FontWeight weight) {
  return Text(
    texto,
    textAlign: TextAlign.center,
    maxLines: 1,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: size, color: color),
  );
}

AppBar myAppBar(String text) {
  return AppBar(
    title: myText(text, 18, Colors.white, FontWeight.bold),
  );
}
