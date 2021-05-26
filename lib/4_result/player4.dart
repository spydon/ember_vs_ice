import 'dart:math';

import 'package:ember_vs_ice/4_result/ice_cube4.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/gestures.dart';

import 'ember4.dart';
import 'ember_game4.dart';

enum PlayerState {
  idle,
  shooting,
}

class Player4 extends SpriteAnimationGroupComponent
    with HasGameRef<EmberGame4>, Draggable, Hitbox, Collidable {
  Player4() : super(animations: {});

  @override
  int get priority => 1;
  final Vector2 gameSize = Vector2.zero();
  final Random rng = Random();
  bool isDragged = false;
  final double shootingRate = 0.5;
  double _reloadTime = 0.3;
  final Vector2 _dragOffset = Vector2.zero();
  bool isScaling = false;
  Vector2 scaleBuffer = Vector2.zero();

  @override
  Future<void> onLoad() async {
    final textureRelation = Vector2(435, 640).normalized();
    size = textureRelation * (min(gameRef.size.x, gameRef.size.y) / 4);
    anchor = Anchor.center;
    position = (gameRef.size / 2)..x = size.x * 2;
    final baseSpriteName = "fire_bender_X.png";
    final sprites = await Future.wait(
      List.generate(
        4,
        (i) => gameRef.loadSprite(baseSpriteName.replaceFirst("X", "${i + 1}")),
      ),
    );
    final idleAnimation =
        SpriteAnimation.spriteList(sprites.sublist(0, 1), stepTime: 100);
    final shootAnimation = SpriteAnimation.spriteList(
      sprites,
      stepTime: _reloadTime,
      loop: false,
    )..onComplete = () {
        animation!.reset();
        current = PlayerState.idle;
      };
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.shooting: shootAnimation,
    };
    current = PlayerState.idle;
    addShape(HitboxRectangle());
  }

  void shoot() {
    final ember = Ember4(
      position + (Vector2(0.6, -0.12)..multiply(size)),
      angle,
    );
    gameRef.add(ember);
    current = PlayerState.shooting;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.gameSize.setFrom(gameSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isDragged) {
      _reloadTime -= dt;
    }
    if (_reloadTime <= 0) {
      shoot();
      _reloadTime = shootingRate;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is IceCube4) {
      final sizeReduction = size.normalized()..multiply(Vector2.all(10));
      scaleBuffer.add(sizeReduction);
      if (!isScaling) {
        isScaling = true;
        final newSize = Vector2.zero();
        Vector2.max(size - scaleBuffer, newSize, newSize);
        addEffect(
          ScaleEffect(
            size: newSize,
            speed: 50,
            onComplete: () {
              isScaling = false;
              if (size.length2 < 250) {
                gameRef.isGameOver = true;
                remove();
              }
            },
          ),
        );
        scaleBuffer.setZero();
      }
    }
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    _dragOffset.setFrom(position - info.eventPosition.game);
    isDragged = true;
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    position = info.eventPosition.game + _dragOffset;
    return false;
  }

  bool onDragEnd(int pointerId, DragEndInfo info) {
    isDragged = false;
    _reloadTime = 0.1;
    return false;
  }

  bool onDragCancel(int pointerId) {
    isDragged = false;
    return false;
  }
}
