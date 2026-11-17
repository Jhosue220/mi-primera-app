class CalculadoraAcademicoController{
  //Suma de las tres notas
  double sumarNotas (double nota1, double nota2, double nota3){
    return nota1 + nota2 + nota3;
  }
  //Promedio de las tres notas
  double promedioNotas (double nota1, double nota2, double nota3){
    return sumarNotas(nota1, nota2, nota3) / 3;
  }
}