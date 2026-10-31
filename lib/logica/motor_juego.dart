import 'grid.dart';
import 'direccion.dart';
import 'estado_juego.dart';

// Aquí se junta todo: cuadrícula, puntaje y si se ganó o se perdió
class MotorJuego {
  Grid grid = Grid.vacio();
  int puntaje = 0;
  EstadoJuego estado = EstadoJuego.jugando;
  static const int objetivoVictoria = 2048; // la ficha que hay que formar para ganar

  // Al empezar la partida salen dos fichas al azar
  MotorJuego() {
    grid.agregarFichaAleatoria();
    grid.agregarFichaAleatoria();
  }

  // Hace un movimiento en la dirección que le pidan
  void mover(Direccion direccion) {
    // Si el juego ya terminó, no hacemos nada
    if (estado != EstadoJuego.jugando) return;

    // Guardamos una copia de cómo estaba la cuadrícula antes de mover
    final antes = grid.celdas.map((f) => List<int?>.from(f)).toList();

    // Movemos según la dirección y guardamos los puntos que se ganaron
    int puntosGanados;
    switch (direccion) {
      case Direccion.izquierda:
        puntosGanados = grid.moverIzquierda();
        break;
      case Direccion.derecha:
        puntosGanados = grid.moverDerecha();
        break;
      case Direccion.arriba:
        puntosGanados = grid.moverArriba();
        break;
      case Direccion.abajo:
        puntosGanados = grid.moverAbajo();
        break;
    }
    puntaje += puntosGanados;

    // Si ya se formó la ficha de 2048, se ganó
    if (grid.haGanado(objetivoVictoria)) {
      estado = EstadoJuego.ganado;
      return;
    }

    // Solo sale una ficha nueva si el movimiento sí cambió algo
    final huboMovimiento = !_gridsIguales(antes, grid.celdas);
    if (huboMovimiento) {
      grid.agregarFichaAleatoria();
    }

    // Si ya no se puede mover nada, se perdió
    if (!grid.hayMovimientosPosibles()) {
      estado = EstadoJuego.perdido;
    }
  }

  // Compara dos cuadrículas casilla por casilla para ver si son iguales
  bool _gridsIguales(List<List<int?>> a, List<List<int?>> b) {
    for (var f = 0; f < a.length; f++) {
      for (var c = 0; c < a[f].length; c++) {
        if (a[f][c] != b[f][c]) return false;
      }
    }
    return true;
  }
}