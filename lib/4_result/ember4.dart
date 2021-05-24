import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/widgets.dart';

class Ember4 extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable {
  @override
  int get priority => 0;
  final Vector2 gameSize = Vector2.zero();
  final Random rng = Random();
  double direction;

  Ember4(Vector2 position, this.direction) : super(position: position);

  @override
  Future<void> onLoad() async {
    size = Vector2.all(10.0 + rng.nextInt(50));
    anchor = Anchor.center;
    animation = await gameRef.loadSpriteAnimation(
      'ember.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(16),
        stepTime: 0.15,
      ),
    );
    final endPosition = position.clone()..x = gameSize.x + size.x;
    final speed = 200.0 + rng.nextInt(300);
    addEffect(MoveEffect(
      path: [endPosition],
      speed: speed,
      curve: Curves.bounceIn,
      onComplete: remove,
    ));
    addShape(HitboxCircle());
    collidableType = CollidableType.passive;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.gameSize.setFrom(gameSize);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {}
}
