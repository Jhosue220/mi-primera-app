import 'package:flutter/material.dart';
import 'package:mi_primera_app/controllers/combustible_controller.dart';

class PantallaCombustible extends StatefulWidget {
  const PantallaCombustible({super.key});

  @override
  State<PantallaCombustible> createState() => _PantallaCombustibleState();
}

class _PantallaCombustibleState extends State<PantallaCombustible> {
  // Controladores para los campos de texto
  final _marcaController = TextEditingController();
  final _distanciaController = TextEditingController();
  final _combustibleController = TextEditingController();

  // Variables para mostrar los resultados en pantalla
  String _marcaMostrada = '';
  double _rendimiento = 0.0;
  String _evaluacion = '';
  bool _calculado = false;

  // Método para ocultar el teclado
  void _ocultarTeclado() {
    FocusScope.of(context).unfocus();
  }

  // Método para procesar el cálculo
  void calcularCombustible() {
    _ocultarTeclado();

    // Validación para evitar campos vacíos
    if (_marcaController.text.isEmpty ||
        _distanciaController.text.isEmpty ||
        _combustibleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Convertimos los valores de forma segura
    double distancia = double.parse(_distanciaController.text);
    double combustible = double.parse(_combustibleController.text);

    if (combustible == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La cantidad de combustible no puede ser cero.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Creamos la instancia del controlador usando el constructor
    final vehiculo = CombustibleController(
      marcaVehiculo: _marcaController.text,
      distanciaRecorrida: distancia,
      cantidadCombustible: combustible,
    );

    setState(() {
      _marcaMostrada = vehiculo.marcaVehiculo;
      _rendimiento = vehiculo.calcularRendimiento();
      _evaluacion = vehiculo.evaluarRendimiento();
      _calculado = true;
    });
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _distanciaController.dispose();
    _combustibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Color dinámico según el rendimiento
    Color colorEvaluacion = _rendimiento >= 15 ? Colors.green : Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Combustible'),
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
                      'Resumen del Vehículo',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    if (_calculado) ...[
                      Text(
                        'Vehículo: $_marcaMostrada',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_rendimiento.toStringAsFixed(2)} km/gal',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorEvaluacion.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _evaluacion,
                          style: TextStyle(
                            color: colorEvaluacion,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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

              // Campo para la Marca del Vehículo
              TextField(
                controller: _marcaController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Marca del Vehículo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para la Distancia Recorrida
              TextField(
                controller: _distanciaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Distancia Recorrida (km)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.map),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para la Cantidad de Combustible
              TextField(
                controller: _combustibleController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Combustible Consumido (galones/litros)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_gas_station),
                ),
              ),
              const SizedBox(height: 24),

              // Botón de cálculo
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: calcularCombustible,
                  child: const Text(
                    'Calcular Rendimiento',
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