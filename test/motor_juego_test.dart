import 'package:flutter_test/flutter_test.dart';
import '../lib/logica/grid.dart';
import '../lib/logica/direccion.dart';
import '../lib/logica/estado_juego.dart';
import '../lib/logica/motor_juego.dart';

void main() {
  // Ronda 10: si el movimiento no cambia nada, no debe salir una ficha nueva
  test('mover sin ningun desplazamiento no agrega una ficha nueva', () {
    final motor = MotorJuego();
    motor.grid = Grid([
      [2, 4, 8, 16],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    final vaciasAntes = motor.grid.celdas.expand((f) => f).where((v) => v == null).length;

    motor.mover(Direccion.izquierda); // la fila ya está pegada a la izquierda y no hay iguales juntas

    final vaciasDespues = motor.grid.celdas.expand((f) => f).where((v) => v == null).length;
    expect(vaciasDespues, vaciasAntes);
  });

  // Si se forma la ficha de 2048, el juego se gana y se suman los puntos
  test('alcanzar el valor objetivo cambia el estado a ganado', () {
    final motor = MotorJuego();
    motor.grid = Grid([
      [1024, 1024, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);

    motor.mover(Direccion.izquierda);

    expect(motor.estado, EstadoJuego.ganado);
    expect(motor.puntaje, 2048);
  });

    // Integración: una jugada completa, mueve, fusiona, suma puntos y agrega ficha
  test('una serie de movimientos combina fichas y acumula puntaje', () {
    final motor = MotorJuego();
    motor.grid = Grid([
      [2, 2, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);

    motor.mover(Direccion.izquierda); // fusiona en 4 y aparece una ficha nueva

    expect(motor.grid.celdas[0][0], 4);
    expect(motor.puntaje, 4);
    expect(motor.estado, EstadoJuego.jugando);
  });
}