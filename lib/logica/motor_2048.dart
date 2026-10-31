// Guarda cómo quedó la fila después de fusionar y cuántos puntos se ganaron
class ResultadoFusion {
  final List<int?> fila;
  final int puntosGanados;
  ResultadoFusion(this.fila, this.puntosGanados);
}

// Guarda cómo quedó la fila después de moverla, los puntos y si algo cambió
class ResultadoMovimiento {
  final List<int?> fila;
  final int puntosGanados;
  final bool seMovio; // true si al menos una ficha cambió de lugar
  ResultadoMovimiento(this.fila, this.puntosGanados, this.seMovio);
}

// Aquí van las reglas para mover las fichas de una fila
class Motor2048 {
  // Quita los huecos (null) y deja las fichas juntas, en el mismo orden
  static List<int?> compactarFila(List<int?> fila) {
    // Nos quedamos solo con las casillas que sí tienen ficha
    final valores = fila.where((v) => v != null).toList();
    // Rellenamos con null al final hasta tener otra vez el mismo tamaño
    while (valores.length < fila.length) {
      valores.add(null);
    }
    return valores;
  }

  // Junta las fichas iguales que están una al lado de la otra
  static ResultadoFusion fusionarFila(List<int?> filaCompactada) {
    // Hacemos una copia para no modificar la fila original
    final resultado = List<int?>.from(filaCompactada);
    var puntos = 0;
    for (var i = 0; i < resultado.length - 1; i++) {
      // Si hay ficha y la de su derecha es igual, las juntamos
      if (resultado[i] != null && resultado[i] == resultado[i + 1]) {
        resultado[i] = resultado[i]! * 2; // la ficha se duplica
        puntos += resultado[i]!; // el valor nuevo se suma al puntaje
        resultado[i + 1] = null; // la otra ficha desaparece
      }
    }
    return ResultadoFusion(resultado, puntos);
  }

  // Mueve toda la fila a la izquierda usando las dos reglas de arriba
  static ResultadoMovimiento moverFilaIzquierda(List<int?> filaOriginal) {
    final compactada = compactarFila(filaOriginal); // 1. juntamos las fichas
    final fusion = fusionarFila(compactada); // 2. fusionamos los pares
    final filaFinal = compactarFila(fusion.fila); // 3. volvemos a juntar, porque al fusionar quedan huecos

    // Comparamos con la fila de antes para saber si algo se movió
    var seMovio = false;
    for (var i = 0; i < filaOriginal.length; i++) {
      if (filaOriginal[i] != filaFinal[i]) seMovio = true;
    }
    return ResultadoMovimiento(filaFinal, fusion.puntosGanados, seMovio);
  }
}