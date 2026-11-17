import 'package:flutter/material.dart';
import 'package:mi_primera_app/controllers/academico_controller.dart';

class PantallaAcademico extends StatefulWidget {
  const PantallaAcademico({super.key});

  @override
  State<PantallaAcademico> createState() => _PantallaAcademicoState();
}

class _PantallaAcademicoState extends State<PantallaAcademico> {
  // Controladores para los campos de texto
  final _nota1Controller = TextEditingController();
  final _nota2Controller = TextEditingController();
  final _nota3Controller = TextEditingController();

  // Instancia del controlador de la calculadora
  final objetoCalculadoraAcademico = CalculadoraAcademicoController();

  // Variables para almacenar y mostrar el resultado y el estado
  double _promedio = 0.0;
  String _estado = '';
  bool _calculado = false; // Bandera para saber si ya se hizo al menos un cálculo

  // Método para ocultar el teclado
  void _ocultarTeclado() {
    FocusScope.of(context).unfocus();
  }

  // Método para calcular el promedio y determinar si aprueba o desaprueba
  void promedioNotas() {
    _ocultarTeclado();

    // Validación básica para evitar errores si algún campo está vacío
    if (_nota1Controller.text.isEmpty ||
        _nota2Controller.text.isEmpty ||
        _nota3Controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todas las notas.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Convertimos y calculamos
    double n1 = double.parse(_nota1Controller.text);
    double n2 = double.parse(_nota2Controller.text);
    double n3 = double.parse(_nota3Controller.text);

    double resultado = objetoCalculadoraAcademico.promedioNotas(n1, n2, n3);

    setState(() {
      _promedio = resultado;
      _calculado = true;

      // Condición: Nota mínima aprobatoria es 13
      if (_promedio >= 13.0) {
        _estado = 'APROBADO';
      } else {
        _estado = 'DESAPROBADO';
      }
    });
  }

  // Liberar controladores
  @override
  void dispose() {
    _nota1Controller.dispose();
    _nota2Controller.dispose();
    _nota3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Definimos el color según el estado (Verde si aprobó, Rojo si desaprobó)
    Color colorEstado = _promedio >= 13.0 ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Académica de Promedio de Notas'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tarjeta contenedora para el resultado del promedio y estado
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withOpacity(0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Promedio Final',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _promedio.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Mostramos el mensaje de Aprobado / Desaprobado solo si ya se calculó
                    if (_calculado)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorEstado.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _estado,
                          style: TextStyle(
                            color: colorEstado,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Campo para la Nota 1
              TextField(
                controller: _nota1Controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Nota 1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para la Nota 2
              TextField(
                controller: _nota2Controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Nota 2',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para la Nota 3
              TextField(
                controller: _nota3Controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Nota 3',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Botón para calcular
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: promedioNotas,
                  child: const Text(
                    'Calcular Promedio',
                    style: TextStyle(fontSize: 16),
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