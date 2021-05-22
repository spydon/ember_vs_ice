import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'ember.dart';
import 'ember_game.dart';

class Player extends SpriteAnimationComponent with HasGameRef<EmberGame>, Draggable {
  @override
  int get priority => 1;
  final Vector2 gameSize = Vector2.zero();
  final Random rng = Random();
  bool isDragged = false;
  final double shootingRate = 0.5;
  double _reloadTime = 0.1;
  final Vector2 _dragOffset = Vector2.zero();

  @override
  Future<void> onLoad() async {
    final textureSize = Vector2(588, 1108);
    size = textureSize / 4;
    angle = pi/2;
    anchor = Anchor.center;
    position = (gameRef.size / 2)..x = size.x * 2;
    animation = await gameRef.loadSpriteAnimation(
      'ice_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: textureSize,
        stepTime: 0.15,
      ),
    );
  }

  PositionComponent createEmber() => Ember(position + Vector2(20, 0), angle);

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.gameSize.setFrom(gameSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(isDragged) {
      _reloadTime -= dt;
    }
    if(_reloadTime <= 0 ) {
      gameRef.add(createEmber());
      _reloadTime = shootingRate;
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
    return false;
  }

  bool onDragCancel(int pointerId) {
    isDragged = false;
    return false;
  }
}
