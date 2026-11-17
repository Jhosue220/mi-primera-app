class ProductoController {
  // Propiedades de la clase
  final String nombreProducto;
  final double precioProducto;
  final int porcentajeDescuento;

  // Constructor para inicializar los valores (¡Corregido el nombre!)
  ProductoController({
    required this.nombreProducto,
    required this.precioProducto,
    required this.porcentajeDescuento,
  });

  // Método para calcular el monto del descuento
  double calcularDescuento() {
    return precioProducto * porcentajeDescuento / 100;
  }

  // Método adicional para calcular el precio final con el descuento aplicado
  double calcularPrecioFinal() {
    return precioProducto - calcularDescuento();
  }
}