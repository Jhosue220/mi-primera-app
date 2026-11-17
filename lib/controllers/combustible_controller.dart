class CombustibleController {
  // Propiedades 
  final String marcaVehiculo;
  final double distanciaRecorrida;
  final double cantidadCombustible;

  // Constructor corregido (con el nombre de la clase)
  CombustibleController({
    required this.marcaVehiculo, 
    required this.distanciaRecorrida, 
    required this.cantidadCombustible,
  });

  // Método para calcular el rendimiento del vehículo (km por unidad de combustible)
  double calcularRendimiento() {
    if (cantidadCombustible <= 0) return 0.0;
    return distanciaRecorrida / cantidadCombustible;
  }

  // Método para calcular el consumo (combustible por km)
  double calcularConsumo() {
    if (distanciaRecorrida <= 0) return 0.0;
    return cantidadCombustible / distanciaRecorrida;
  }

  // Método corregido para evaluar el rendimiento con un mensaje
  String evaluarRendimiento() {
    // Si recorre 15 o más kilómetros por cada unidad de combustible
    if (calcularRendimiento() >= 15) {
      return "Buen rendimiento";
    } else {
      return "Rendimiento bajo";
    }
  }
}