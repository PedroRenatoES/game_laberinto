import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Square extends RectangleComponent {
  bool isSpecial; // Nueva propiedad para identificar cuadrados especiales
  bool isBad;

  Square({
    required Vector2 position,
    required Vector2 size,
    required Paint paint,
    this.isSpecial = false, // Inicializa isSpecial por defecto en false
    this.isBad = false
  }) : super(
          position: position,
          size: size,
          paint: paint,
        );
}
