import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

import 'ember4.dart';
import 'ember_game4.dart';

class Explosion extends SpriteAnimationComponent with HasGameRef {
  @override
  int get priority => 5;
  Random _rng = Random();

  Explosion(Vector2 position) : super(position: position);

  @override
  Future<void> onLoad() async {
    size = Vector2.all(1) * (350.0 + _rng.nextInt(100));
    anchor = Anchor.center;
    final textureSize = Vector2.all(126);
    animation = await gameRef.loadSpriteAnimation(
      'boom.png',
      SpriteAnimationData.sequenced(
        amount: 64,
        textureSize: textureSize,
        stepTime: 0.1,
        loop: false,
      ),
    );
    removeOnFinish = true;
  }
}
