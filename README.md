# nieves_2048

Ronda 1: compactar una fila
test/motor_2048_test.dart:
rojo
<img width="1208" height="500" alt="image" src="https://github.com/user-attachments/assets/5a652fa1-c16e-4ee6-b3d8-b6b8918f4afd" />
import 'package:flutter_test/flutter_test.dart';
import 'package:nieves_2080/logica/motor_2048.dart';

void main() {
  // Ronda 1: null se van al final y las fichas se quedan en orden
  test('compactarFila quita los huecos y mantiene el orden', () {
    final resultado = Motor2048.compactarFila([2, null, 4, null]);
    expect(resultado, [2, 4, null, null]);
  });

  // Si no hay huecos la fila se queda igual
  test('compactarFila sin huecos no cambia nada', () {
    final resultado = Motor2048.compactarFila([2, 4, 8, 16]);
    expect(resultado, [2, 4, 8, 16]);
  });
}

verde 
<img width="923" height="253" alt="image" src="https://github.com/user-attachments/assets/76070dc5-1e7a-4af3-9f62-6a617d3920d9" />
<img width="958" height="34" alt="image" src="https://github.com/user-attachments/assets/f10bd214-9d3f-4fea-9c26-d1031615cd35" />


## Ronda 2: fusionar pares iguales

# rojo
test/motor_2048_test.dart
<img width="1211" height="398" alt="image" src="https://github.com/user-attachments/assets/f78b5268-13b6-43be-beed-f878c59129dd" />

## verde
<img width="497" height="122" alt="image" src="https://github.com/user-attachments/assets/f28f6e2e-f79d-437d-a196-76be02c9560e" />


# Ronda 3: mover una fila completa a la izquierda

## Rojo
<img width="1201" height="447" alt="image" src="https://github.com/user-attachments/assets/af4b8c23-89a0-45a5-a613-5a21513a29cb" />

## verde
<img width="663" height="190" alt="image" src="https://github.com/user-attachments/assets/c0bfffe8-5975-4c42-b8c1-b6fd5a0bc5b4" />


## Ronda 4: mover toda la cuadrícula a la izquierda

## ROJO
<img width="1210" height="418" alt="image" src="https://github.com/user-attachments/assets/6ee1c177-06e1-4516-98fc-2d4dc344fcae" />

# VERDE
<img width="1130" height="209" alt="image" src="https://github.com/user-attachments/assets/73d72a9e-e4d3-42bd-af09-64b91dcd6a5b" />

## Ronda 5: mover a la derecha
## ROJO
<img width="1211" height="487" alt="image" src="https://github.com/user-attachments/assets/a02efbbd-8a05-49c7-b147-8a28a72aacae" />

# VERDE
<img width="1210" height="567" alt="image" src="https://github.com/user-attachments/assets/9429cd42-b2c6-4207-b35b-3035a8ecf924" />
<img width="1206" height="531" alt="image" src="https://github.com/user-attachments/assets/1c30ba25-8ad5-4fbf-a995-25c4b1aee076" />

Ronda 6: mover arriba y abajo
# rojo
<img width="1205" height="462" alt="image" src="https://github.com/user-attachments/assets/c4db8370-f7f4-4230-97ea-0799ba71b3c6" />

# verde
<img width="1062" height="234" alt="image" src="https://github.com/user-attachments/assets/b77813d1-1aab-4c8e-8552-48d06e1b2582" />
<img width="1208" height="496" alt="image" src="https://github.com/user-attachments/assets/04cbbcfd-3357-473b-8642-6b7aebcdbb43" />

# Ronda 7: agregar una ficha nueva al azar
# rojo
<img width="1046" height="502" alt="image" src="https://github.com/user-attachments/assets/c4e7bef6-2276-4b48-a0a2-c2794a1f4e3d" />

#verde
<img width="1077" height="226" alt="image" src="https://github.com/user-attachments/assets/24a87562-23b1-4502-a46a-acaa7ef174e1" />
<img width="1201" height="522" alt="image" src="https://github.com/user-attachments/assets/27123af4-a17c-4383-9e31-8522777d323b" />


#Ronda 8: detectar si ya no hay movimientos

# rojo
<img width="1213" height="395" alt="image" src="https://github.com/user-attachments/assets/54d3c644-bfbd-4316-b83f-e3b72ba93259" />

# verde
<img width="1208" height="410" alt="image" src="https://github.com/user-attachments/assets/66ad4e8b-8204-4fb3-bb0a-fcef0dc5fa5b" />

# Ronda 9: detectar la victoria

# rojo

<img width="1210" height="470" alt="image" src="https://github.com/user-attachments/assets/9eac85d5-da04-4432-b290-6c7286068fd6" />

# verde
<img width="1222" height="281" alt="image" src="https://github.com/user-attachments/assets/d6ec92fa-f3b1-4c0b-a8cc-1c81be8eaf62" />

Ronda 10: MotorJuego, juntar todo (puntaje, victoria y derrota)

# rojo

<img width="1197" height="559" alt="image" src="https://github.com/user-attachments/assets/57254af5-bc0c-470d-846a-decb726fe587" />

# verde





