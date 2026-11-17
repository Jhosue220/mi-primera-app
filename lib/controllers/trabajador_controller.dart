class CalculadoraTrabajadorController {
  // Propiedades de la clase
  final String nombreTrabajador;
  final double horasTrabajadas;
  final double pagaPorHora;

  // Constructor para inicializar los valores
  CalculadoraTrabajadorController({
    required this.nombreTrabajador,
    required this.horasTrabajadas,
    required this.pagaPorHora,
  });

  // Método para calcular el sueldo aplicando la regla de hasta 48 horas y horas extras
  String calcularSueldoConHoras() {
    // Si el trabajador realiza hasta 48 horas
    if (horasTrabajadas <= 48) {
      double sueldo = horasTrabajadas * pagaPorHora;
      return "El sueldo de $nombreTrabajador es: \$$sueldo";
    } 
    // Si trabaja más de 48 horas (las horas adicionales se pagan con un 50% más)
    else {
      double sueldoNormal = 48 * pagaPorHora;
      double horasExtras = horasTrabajadas - 48;
      double pagoHorasExtras = horasExtras * (pagaPorHora * 1.5); // 1.5 representa el pago normal + 50%
      double sueldoTotal = sueldoNormal + pagoHorasExtras;
      
      return "El sueldo de $nombreTrabajador es: \$$sueldoTotal (Incluye horas extras)";
    }
  }
}