import 'package:flutter/material.dart';

// Strings URL
const base_url = 'http://127.0.0.1:8000/api';
const login_url = '$base_url/login/';
const register_url = '$base_url/register/';
const logout_url = "$base_url/logout/";
const user_detail_url = "$base_url/user/";

// Errores
const somethingWentWrong = 'Ha occurido un error, de nuevo';
const serverError = 'Error en el Servidor';
const unauthorized = 'No Autorizado';

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
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
      Text(text),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Text(
          label,
          style: const TextStyle(color: Colors.blue),
        ),
        onTap: () => onTab(),
      )
    ],
  );
}
