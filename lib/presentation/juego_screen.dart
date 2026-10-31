import 'package:flutter/material.dart';
import '../logica/motor_juego.dart';
import '../logica/direccion.dart';
import '../logica/estado_juego.dart';

// Cada casilla del juego, con su color y su sabor de nieve
class Ficha extends StatelessWidget {
  final int? valor;
  const Ficha({super.key, required this.valor});

  // Los dos colores del degradado de cada valor
  static const Map<int, List<Color>> _gradientes = {
    2: [Color(0xFFFFFDE7), Color(0xFFFFF9C4)],
    4: [Color(0xFFF8BBD0), Color(0xFFF48FB1)],
    8: [Color(0xFFD7CCC8), Color(0xFFA1887F)],
    16: [Color(0xFFFFE0B2), Color(0xFFFFB74D)],
    32: [Color(0xFFC8E6C9), Color(0xFF81C784)],
    64: [Color(0xFFE1BEE7), Color(0xFFBA68C8)],
    128: [Color(0xFF8D6E63), Color(0xFF4E342E)],
    256: [Color(0xFFFFE082), Color(0xFFFFC107)],
    512: [Color(0xFF6D4C41), Color(0xFF3E2723)],
    1024: [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
    2048: [Color(0xFF006341), Color(0xFFFFFFFF)],
  };

  // El sabor que lleva cada número
  static const Map<int, String> _nombres = {
    2: 'Vainilla', 4: 'Fresa', 8: 'Chocolate', 16: 'Mango',
    32: 'Limón', 64: 'Uva', 128: 'Mole', 256: 'Tequila',
    512: 'Café', 1024: 'Rompope', 2048: 'Independencia',
  };

  @override
  Widget build(BuildContext context) {
    final v = valor; // copia local para poder usarla sin que sea null
    final colores = _gradientes[v] ?? [Colors.grey.shade200, Colors.grey.shade300];
    // En las fichas oscuras el texto va en blanco
    final textoClaro = v == 128 || v == 512;

    // AnimatedSwitcher hace la animación cuando la ficha cambia de valor
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animacion) => ScaleTransition(scale: animacion, child: child),
      child: Container(
        key: ValueKey(v),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colores, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(12),
          boxShadow: v == null
              ? []
              : const [BoxShadow(color: Color(0x26000000), blurRadius: 4, offset: Offset(0, 2))],
        ),
        alignment: Alignment.center,
        child: v == null
            ? null
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    v.toString(),
                    style: TextStyle(
                      fontSize: v >= 128 ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: textoClaro ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    _nombres[v] ?? '',
                    style: TextStyle(fontSize: 10, color: textoClaro ? Colors.white70 : Colors.black54),
                  ),
                ],
              ),
      ),
    );
  }
}

// La pantalla principal del juego
class JuegoScreen extends StatefulWidget {
  const JuegoScreen({super.key});
  @override
  State<JuegoScreen> createState() => _JuegoScreenState();
}

class _JuegoScreenState extends State<JuegoScreen> {
  late MotorJuego _motor;
    // Aquí se va sumando lo que se arrastra el dedo en cada gesto
  Offset _desplazamiento = Offset.zero;

  @override
  void initState() {
    super.initState();
    _motor = MotorJuego(); // empieza una partida nueva
  }

  // Cuando se desliza el dedo, la pantalla solo le pasa la dirección al motor
  void _mover(Direccion direccion) {
    setState(() => _motor.mover(direccion));
    if (_motor.estado != EstadoJuego.jugando) _mostrarResultado();
  }

  // Aviso con animación cuando se gana o se pierde
  void _mostrarResultado() {
    final gano = _motor.estado == EstadoJuego.ganado;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'resultado',
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.elasticOut),
          child: FadeTransition(
            opacity: anim1,
            child: AlertDialog(
              title: Text(gano ? '¡Independencia lograda!' : 'Se acabaron los movimientos'),
              content: Text('Puntaje final: ' + _motor.puntaje.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => _motor = MotorJuego()); // partida nueva
                  },
                  child: const Text('Jugar de nuevo'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nieves 2048 - Dolores Hidalgo')),
      body: Column(
        children: [
          // El puntaje sube con animación
          Padding(
            padding: const EdgeInsets.all(16),
            child: TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: _motor.puntaje),
              duration: const Duration(milliseconds: 400),
              builder: (context, valor, _) => Text(
                'Puntaje: ' + valor.toString(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            // GestureDetector detecta hacia dónde desliza el dedo
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              // Al empezar a arrastrar, reiniciamos la cuenta
              onPanStart: (_) => _desplazamiento = Offset.zero,
              // Mientras arrastra, vamos sumando cuánto se movió
              onPanUpdate: (detalle) => _desplazamiento += detalle.delta,
              // Al soltar, vemos hacia dónde fue más
              onPanEnd: (_) {
                final dx = _desplazamiento.dx;
                final dy = _desplazamiento.dy;
                // Si arrastró muy poquito, no cuenta como movimiento
                if (dx.abs() < 20 && dy.abs() < 20) return;
                if (dx.abs() > dy.abs()) {
                  _mover(dx > 0 ? Direccion.derecha : Direccion.izquierda);
                } else {
                  _mover(dy > 0 ? Direccion.abajo : Direccion.arriba);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, i) {
                    final valor = _motor.grid.celdas[i ~/ 4][i % 4];
                    return Ficha(valor: valor);
                  },
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Desliza en cualquier dirección para mover las nieves'),
          ),
        ],
      ),
    );
  }
}