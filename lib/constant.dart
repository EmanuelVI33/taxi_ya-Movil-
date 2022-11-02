import 'package:flutter/material.dart';

// Strings URL
const baseUrl = 'https://julicosuarez.ga/api';
const apiToken = 'base64:1hA0CRnnm5lka5NKzVSOYAb+btjEOQXD+B384ZxlAR4=';
const loginUrl = '$baseUrl/login/';
const registerUrl = '$baseUrl/register/';
const logoutUrl = "$baseUrl/logout/";
const userDetailUrl = "$baseUrl/user/";

// Errores
const somethingWentWrong = 'Ha occurido un error, de nuevo';
const serverError = 'Error en el Servidor';
const unauthorized = 'No Autorizado';

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
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
                (states) => EdgeInsets.symmetric(vertical: 10))),
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
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
        style: TextStyle(fontSize: 18),
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
