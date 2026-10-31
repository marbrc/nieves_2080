import 'package:flutter_test/flutter_test.dart';
import '../lib/logica/motor_2048.dart';
void main() {
  // Ronda 1: los huecos (null) se van al final y las fichas se quedan en orden
  test('compactarFila quita los huecos y mantiene el orden', () {
    final resultado = Motor2048.compactarFila([2, null, 4, null]);
    expect(resultado, [2, 4, null, null]);
  });

  // Si no hay huecos la fila se queda igual
  test('compactarFila sin huecos no cambia nada', () {
    final resultado = Motor2048.compactarFila([2, 4, 8, 16]);
    expect(resultado, [2, 4, 8, 16]);
  });

  // Ronda 2: dos fichas iguales juntas se hacen una del doble
  test('fusionarFila combina un par adyacente igual', () {
    final resultado = Motor2048.fusionarFila([2, 2, 4, null]);
    expect(resultado.fila, [4, null, 4, null]);
    expect(resultado.puntosGanados, 4);
  });

  // Con tres iguales seguidos solo se fusiona un par, no las tres
  test('fusionarFila no fusiona tres iguales seguidos mas de una vez', () {
    final resultado = Motor2048.fusionarFila([2, 2, 2, null]);
    expect(resultado.fila, [4, null, 2, null]);
    expect(resultado.puntosGanados, 4);
  });

  // Ronda 3: mover la fila a la izquierda junta, fusiona y vuelve a juntar
  test('mover una fila hacia la izquierda compacta y fusiona correctamente', () {
    final resultado = Motor2048.moverFilaIzquierda([null, 2, 2, 4]);
    expect(resultado.fila, [4, 4, null, null]);
    expect(resultado.puntosGanados, 4);
    expect(resultado.seMovio, true);
  });

  // Si la fila ya está en su lugar, no se movió nada
  test('una fila ya en su posicion final reporta seMovio en falso', () {
    final resultado = Motor2048.moverFilaIzquierda([2, 4, null, null]);
    expect(resultado.seMovio, false);
  });
}