import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'ember.dart';
import 'ember_game.dart';

enum PlayerState {
  idle,
  shooting,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<EmberGame>, Draggable {

  Player() : super(animations: {});

  @override
  int get priority => 1;
  bool isDragged = false;
  final double shootingRate = 0.5;
  double _reloadTime = 0.3;

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
  }

  void shoot() {
    gameRef.add(createEmber());
    current = PlayerState.shooting;
    _reloadTime = shootingRate;
  }

  PositionComponent createEmber() {
    return Ember(position + (Vector2(0.6, -0.12)..multiply(size)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isDragged) {
      _reloadTime -= dt;
    }
    if (_reloadTime <= 0) {
      shoot();
    }
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    isDragged = true;
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    position += info.delta.game;
    return false;
  }

  bool onDragEnd(int pointerId, DragEndInfo info) {
    isDragged = false;
    return false;
  }

  bool onDragCancel(int pointerId) {
    isDragged = false;
    return false;
  }
}
