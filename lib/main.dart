import 'package:flutter/material.dart';
import 'pantallas/pantalla_academico.dart';
import 'pantallas/pantalla_trabajador.dart';

void main() {
  //El runApp nos permite ejecutar nuestro programa
  runApp(
    const MaterialApp(
      //El home nos permite definir la pantalla que se va a mostrar al iniciar el programa
      home: PantallaTrabajador(),
    ),
  );
}