import 'package:ember_vs_ice/1_basic_setup/player.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import 'ember3.dart';

class Player3 extends Player with Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxRectangle());
  }

  @override
  PositionComponent createEmber() => Ember3(position + Vector2(20, 0), angle);

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  }
}
