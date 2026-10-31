import 'dart:math';
import 'motor_2048.dart';

// Esta clase es la cuadrícula completa del juego, de 4x4
class Grid {
  List<List<int?>> celdas; // cada fila es una lista, null es una casilla vacía
  Grid(this.celdas);

  // Crea una cuadrícula de 4x4 con todas las casillas vacías
  static Grid vacio() => Grid(List.generate(4, (_) => List.generate(4, (_) => null)));

  // Mueve las 4 filas a la izquierda y regresa los puntos que se ganaron
  int moverIzquierda() {
    var puntos = 0;
    for (var f = 0; f < celdas.length; f++) {
      // Usamos lo que ya hicimos para mover una fila
      final resultado = Motor2048.moverFilaIzquierda(celdas[f]);
      celdas[f] = resultado.fila; // la fila se cambia por la nueva
      puntos += resultado.puntosGanados; // se suman los puntos de cada fila
    }
    return puntos;
  }

  // Mueve las 4 filas a la derecha reutilizando el movimiento a la izquierda
  int moverDerecha() {
    var puntos = 0;
    for (var f = 0; f < celdas.length; f++) {
      // 1. Volteamos la fila para que la derecha quede como izquierda
      final invertida = celdas[f].reversed.toList();
      // 2. Movemos a la izquierda como siempre
      final resultado = Motor2048.moverFilaIzquierda(invertida);
      // 3. Volvemos a voltear la fila para dejarla en su orden original
      celdas[f] = resultado.fila.reversed.toList();
      puntos += resultado.puntosGanados;
    }
    return puntos;
  }

  // Cambia las filas por columnas, así lo de arriba pasa a ser lo de la izquierda
  List<List<int?>> _transponer(List<List<int?>> g) {
    final n = g.length;
    return List.generate(n, (i) => List.generate(n, (j) => g[j][i]));
  }

  // Mueve hacia arriba: transponemos, movemos a la izquierda y volvemos a transponer
  int moverArriba() {
    celdas = _transponer(celdas);
    final puntos = moverIzquierda();
    celdas = _transponer(celdas);
    return puntos;
  }

  // Mueve hacia abajo: igual, pero moviendo a la derecha
  int moverAbajo() {
    celdas = _transponer(celdas);
    final puntos = moverDerecha();
    celdas = _transponer(celdas);
    return puntos;
  }

  // Pone una ficha nueva en una casilla vacía al azar
  void agregarFichaAleatoria({Random? aleatorio}) {
    // Si no nos pasan un Random usamos uno normal, así en las pruebas lo podemos controlar
    final rnd = aleatorio ?? Random();

    // Buscamos todas las casillas vacías y guardamos su posición [fila, columna]
    final vacias = <List<int>>[];
    for (var f = 0; f < celdas.length; f++) {
      for (var c = 0; c < celdas[f].length; c++) {
        if (celdas[f][c] == null) vacias.add([f, c]);
      }
    }
    // Si no hay lugar, no hacemos nada
    if (vacias.isEmpty) return;

    // Elegimos una casilla vacía al azar
    final elegida = vacias[rnd.nextInt(vacias.length)];
    // 90% de las veces sale un 2 y 10% un 4
    final valor = rnd.nextDouble() < 0.9 ? 2 : 4;
    celdas[elegida[0]][elegida[1]] = valor;
  }


    // Dice si queda alguna casilla vacía
  bool hayCeldasVacias() => celdas.expand((f) => f).any((v) => v == null);

  // Dice si todavía se puede hacer algún movimiento
  bool hayMovimientosPosibles() {
    // 1. Si hay una casilla vacía, sí se puede mover
    if (hayCeldasVacias()) return true;

    // 2. Revisamos si hay dos fichas iguales una al lado de la otra (horizontal)
    for (var f = 0; f < celdas.length; f++) {
      for (var c = 0; c < celdas[f].length - 1; c++) {
        if (celdas[f][c] == celdas[f][c + 1]) return true;
      }
    }
    // 3. Lo mismo pero una arriba de la otra (vertical)
    for (var c = 0; c < celdas.length; c++) {
      for (var f = 0; f < celdas.length - 1; f++) {
        if (celdas[f][c] == celdas[f + 1][c]) return true;
      }
    }
    // Si no pasó nada de lo anterior, el juego se acabó
    return false;
  }

    // Dice si alguna casilla ya llegó al valor que hay que alcanzar para ganar
  bool haGanado(int objetivo) =>
      celdas.expand((f) => f).any((v) => v != null && v >= objetivo);
}