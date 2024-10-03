import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_juego/cuadrado.dart';

class LevelChangeSquare extends Square {
  LevelChangeSquare({
    required Vector2 position,
    required Vector2 size,
    required Paint paint,
  }) : super(position: position, size: size, paint: paint);
}
