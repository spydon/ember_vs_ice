import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

import 'ember4.dart';
import 'ember_game4.dart';
import 'explosion.dart';

class IceCube4 extends SpriteAnimationComponent
    with HasGameRef<EmberGame4>, Hitbox, Collidable {
  @override
  int get priority => 2;
  final Vector2 gameSize = Vector2.zero();
  final Random rng = Random();
  late final double speed;
  bool isScaling = false;
  Vector2 scaleBuffer = Vector2.zero();

  IceCube4(Vector2 position) : super(position: position);

  @override
  Future<void> onLoad() async {
    speed = 50 + rng.nextInt(50).toDouble();
    final textureSize = Vector2(588, 1108);
    final textureRelation = textureSize.normalized();
    size =
        textureRelation * (25 + (gameRef.size.length / 3) * rng.nextDouble());
    Vector2.min(size, textureRelation * 300, size);
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
    final rectangle = HitboxRectangle(relation: Vector2(1.0, 0.5))
      ..relativeOffset = Vector2(0.0, -0.5);
    addShape(rectangle);
    final circle = HitboxCircle()..relativeOffset = Vector2(0.0, 0.5);
    addShape(rectangle);
    addShape(circle);
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

  @override
  void onRemove() {
    super.onRemove();
    if (!gameRef.isGameOver) {
      gameRef.score++;
      gameRef.spawnRate = max(gameRef.spawnRate - 0.5, 0.5);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Ember4) {
      final sizeReduction = size.normalized()..multiply(other.size);
      if (!isScaling) {
        final newSize = Vector2.zero();
        Vector2.max(size - scaleBuffer - sizeReduction, newSize, newSize);
        shrink(newSize);
        scaleBuffer.setZero();
      } else {
        scaleBuffer.add(sizeReduction);
      }
      other.remove();
    }
  }

  void shrink(Vector2 newSize) {
    isScaling = true;
    addEffect(
      ScaleEffect(
        size: newSize,
        speed: 50,
        onComplete: () {
          isScaling = false;
          if (size.length2 < 4000) {
            remove();
            gameRef.add(Explosion(position.clone()));
          }
        },
      ),
    );
  }
}
