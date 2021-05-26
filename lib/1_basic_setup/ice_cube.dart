import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'ember_game.dart';

class IceCube extends SpriteAnimationComponent with HasGameRef<EmberGame> {
  @override
  int get priority => 2;
  final Vector2 gameSize = Vector2.zero();
  final Random rng = Random();
  late final double speed;

  IceCube(Vector2 position) : super(position: position);

  @override
  Future<void> onLoad() async {
    speed = 50 + rng.nextInt(50).toDouble();
    final textureSize = Vector2(588, 1108);
    size = textureSize / 4;
    angle = rng.nextDouble() * 6;
    anchor = Anchor.center;
    animation = await gameRef.loadSpriteAnimation(
      'ice_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: textureSize,
        stepTime: 0.15,
      ),
    );
    addEffect(RotateEffect(
      angle: 3,
      speed: 0.2,
      isRelative: true,
      isAlternating: true,
      isInfinite: true,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.gameSize.setFrom(gameSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    final direction = (gameRef.player.position - position).normalized();
    position.add(direction * speed * dt);
  }
}
