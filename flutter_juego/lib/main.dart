import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_juego/game.dart';

void main() {
  final game = BallGame();

  runApp(GameWidget(game: game, overlayBuilderMap: {
    'CongratulationsOverlay': (context, game) =>
        CongratulationsOverlay(game: game as BallGame),
  }));
}
