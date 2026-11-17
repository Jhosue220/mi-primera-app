import 'package:flutter/material.dart';
import 'package:mi_primera_app/controllers/trabajador_controller.dart';

class PantallaTrabajador extends StatefulWidget {
  const PantallaTrabajador({super.key});

  @override
  State<PantallaTrabajador> createState() => _PantallaTrabajadorState();
}

class _PantallaTrabajadorState extends State<PantallaTrabajador> {
  // Controladores para los campos de texto
  final _nombreController = TextEditingController();
  final _horasController = TextEditingController();
  final _pagoController = TextEditingController();

  // Variables para mostrar los resultados en pantalla
  String _nombreMostrado = '';
  double _sueldoTotal = 0.0;
  bool _calculado = false;

  // Método para ocultar el teclado
  void _ocultarTeclado() {
    FocusScope.of(context).unfocus();
  }

  // Método para procesar el cálculo del sueldo
  void calcularSueldoTrabajador() {
    _ocultarTeclado();

    // Validación para evitar campos vacíos
    if (_nombreController.text.isEmpty ||
        _horasController.text.isEmpty ||
        _pagoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Convertimos de forma segura los valores numéricos
    double horas = double.parse(_horasController.text);
    double pago = double.parse(_pagoController.text);

    // Creamos la instancia del controlador usando el constructor (Opción 2)
    final calculadora = CalculadoraTrabajadorController(
      nombreTrabajador: _nombreController.text,
      horasTrabajadas: horas,
      pagaPorHora: pago,
    );

    setState(() {
      _nombreMostrado = calculadora.nombreTrabajador;
      // Llamamos al método directamente desde el objeto instanciado
      _sueldoTotal = calculadora.calcularSueldo();
      _calculado = true;
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _horasController.dispose();
    _pagoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Sueldo de Trabajador'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tarjeta contenedora de resultados
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
                      'Resumen de Pago',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    if (_calculado) ...[
                      Text(
                        'Trabajador: $_nombreMostrado',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'S/ ${_sueldoTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ] else
                      const Text(
                        'Ingrese los datos para calcular',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Campo para el Nombre del Trabajador
              TextField(
                controller: _nombreController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Trabajador',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para las Horas Trabajadas
              TextField(
                controller: _horasController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Horas Trabajadas',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para la Paga por Hora
              TextField(
                controller: _pagoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Paga por Hora (S/.)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 24),

              // Botón de cálculo
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: calcularSueldoTrabajador,
                  child: const Text(
                    'Calcular Sueldo',
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