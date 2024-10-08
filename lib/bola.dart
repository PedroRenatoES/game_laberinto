import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent {
  Ball({
    required Vector2 position,
    required double radius,
  }) : super(
          position: position,
          radius: radius,
          paint: Paint()..color = const Color.fromARGB(255, 40, 195, 206), // Color blanco para la bola
        );
}
