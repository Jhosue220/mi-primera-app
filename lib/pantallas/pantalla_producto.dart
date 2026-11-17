import 'package:flutter/material.dart';
import 'package:mi_primera_app/controllers/producto_controller.dart';

class PantallaProducto extends StatefulWidget {
  const PantallaProducto({super.key});

  @override
  State<PantallaProducto> createState() => _PantallaProductoState();
}

class _PantallaProductoState extends State<PantallaProducto> {
  // Controladores para los campos de texto
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _descuentoController = TextEditingController();

  // Variables para mostrar los resultados en pantalla
  String _nombreMostrado = '';
  double _montoDescuento = 0.0;
  double _precioFinal = 0.0;
  bool _calculado = false;

  // Método para ocultar el teclado
  void _ocultarTeclado() {
    FocusScope.of(context).unfocus();
  }

  // Método para procesar el cálculo
  void calcularProducto() {
    _ocultarTeclado();

    // Validación para evitar campos vacíos
    if (_nombreController.text.isEmpty ||
        _precioController.text.isEmpty ||
        _descuentoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Convertimos los valores de forma segura
    double precio = double.parse(_precioController.text);
    int descuento = int.parse(_descuentoController.text);

    // Creamos la instancia del controlador pasando los datos al constructor
    final producto = ProductoController(
      nombreProducto: _nombreController.text,
      precioProducto: precio,
      porcentajeDescuento: descuento,
    );

    setState(() {
      _nombreMostrado = producto.nombreProducto;
      _montoDescuento = producto.calcularDescuento();
      _precioFinal = producto.calcularPrecioFinal();
      _calculado = true;
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _descuentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Descuentos'),
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
                      'Resumen del Producto',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    if (_calculado) ...[
                      Text(
                        _nombreMostrado,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Descuento: - S/ ${_montoDescuento.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Precio Final: S/ ${_precioFinal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 30,
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

              // Campo para el Nombre del Producto
              TextField(
                controller: _nombreController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Producto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para el Precio del Producto
              TextField(
                controller: _precioController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Precio Original (S/.)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: 16),

              // Campo para el Porcentaje de Descuento
              TextField(
                controller: _descuentoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Porcentaje de Descuento (Ej: 20)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_offer),
                ),
              ),
              const SizedBox(height: 24),

              // Botón de cálculo
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: calcularProducto,
                  child: const Text(
                    'Calcular Descuento',
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