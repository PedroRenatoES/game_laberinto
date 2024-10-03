import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juego/bola.dart';
import 'package:flutter_juego/cuadrado.dart';
import 'package:flutter_juego/cuadradoEspecial.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BallGame extends FlameGame {
  Ball? ball;
  int levelCounter = 0; // Contador de niveles
  int maxLevels = 3; // Número máximo de niveles
  static const int rows = 14; // Número de filas
  static const int cols = 14; // Número de columnas
  static const double squareSize = 30; // Tamaño de los cuadrados

  List<List<int>> maze1 = [
    [1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0],
    [0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0],
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0],
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0],
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
  ];

  List<List<int>> maze2 = [
    [1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1],
  ];

  List<List<int>> maze3 = [
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 2, 0, 1],
    [1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1],
    [1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1],
    [1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1],
    [1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
    [1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1],
  ];

  @override
  Future<void> onLoad() async {
    // Inicializar la bola en el centro de la pantalla
    ball = Ball(
      position: Vector2(size.x / 2, size.y - 50),
      radius: 10,
    );

    add(ball!);
    double offsetX = (size.x - (cols * squareSize)) / 2;
    double offsetY = (size.y - (rows * squareSize)) / 2;

    loadMaze(maze1, offsetX, offsetY); // Cargar el primer laberinto

    // Escuchar eventos del acelerómetro
    accelerometerEventStream().listen((event) {
      if (ball != null) {
        final newX = (ball!.position.x - event.x * 0.65)
            .clamp(0.0, size.x - ball!.radius * 2);
        final newY = (ball!.position.y + event.y * 0.65)
            .clamp(0.0, size.y - ball!.radius * 2);
        ball!.position = Vector2(newX, newY);
        checkCollisions();
      }
    });
  }

  void loadMaze(List<List<int>> maze, double offsetX, double offsetY) {
    for (int row = 0; row < maze.length; row++) {
      for (int col = 0; col < maze[row].length; col++) {
        double x = offsetX + col * squareSize;
        double y = offsetY + row * squareSize;

        Paint paint;
        bool isSpecial = false;

        if (maze[row][col] == 1) {
          paint = Paint()..color = Colors.white; // Cuadrado normal
        } else if (maze[row][col] == 2) {
          paint = Paint()..color = Colors.green; // Cuadrado especial
          isSpecial = true; // Marca como especial
        } else {
          continue; // No crear nada si es 0 (vacío)
        }

        // Crear y añadir el cuadrado
        children.add(Square(
          position: Vector2(x, y),
          size: Vector2(squareSize, squareSize),
          paint: paint,
          isSpecial: isSpecial, // Propiedad isSpecial
        ));
      }
    }
  }

  void checkCollisions() {
    for (final component in children) {
      if (component is Square) {
        if (ball!.toRect().overlaps(component.toRect())) {
          if (component.isSpecial) {
            levelCounter++; // Incrementar el contador de niveles
            children.clear(); // Limpiar el laberinto actual
            double offsetX = (size.x - (cols * squareSize)) / 2;
            double offsetY = (size.y - (rows * squareSize)) / 2;

            // Cargar el siguiente laberinto si no se ha alcanzado el máximo de niveles
            if (levelCounter < maxLevels) {
              switch (levelCounter) {
                case 1:
                  loadMaze(
                      maze2, offsetX, offsetY); // Cargar el segundo laberinto
                  break;
                case 2:
                  loadMaze(
                      maze3, offsetX, offsetY); // Cargar el tercer laberinto
                  break;
              }
            } else {
              showCongratulationsScreen();
            }

            add(ball!);
            ball!.position =
                Vector2(size.x / 2, size.y - 50); // Reposicionar la bola
            return; // Salir después de cargar el nuevo laberinto
          } else {
            // Ajustar la posición de la bola según la dirección de la colisión
            adjustBallPosition(component);
          }
        }
      }
    }
  }

  void adjustBallPosition(Square component) {
    final ballRect = ball!.toRect();
    final squareRect = component.toRect();

    // Determinar la dirección de la colisión
    final dx = (ballRect.center.dx - squareRect.center.dx).abs();
    final dy = (ballRect.center.dy - squareRect.center.dy).abs();

    // Comprobar cuál es el lado más cercano y ajustar la posición de la bola
    if (dx > dy) {
      // Colisión lateral
      if (ballRect.center.dx < squareRect.center.dx) {
        // Colisión por la izquierda
        ball!.position.x = squareRect.left - ball!.radius * 2;
      } else {
        // Colisión por la derecha
        ball!.position.x = squareRect.right;
      }
    } else {
      // Colisión superior o inferior
      if (ballRect.center.dy < squareRect.center.dy) {
        // Colisión por arriba
        ball!.position.y = squareRect.top - ball!.radius * 2;
      } else {
        // Colisión por abajo
        ball!.position.y = squareRect.bottom;
      }
    }
  }

  void showCongratulationsScreen() {
    // Detener el juego
    // Aquí puedes mostrar un widget con el mensaje de felicitaciones
    overlays.add('CongratulationsOverlay');
  }
}

// Clase para la pantalla de felicitaciones
class CongratulationsOverlay extends StatelessWidget {
  final BallGame game;

  CongratulationsOverlay({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¡Felicidades!',
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
