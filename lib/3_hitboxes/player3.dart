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
  PositionComponent createEmber() {
    return Ember3(position + (Vector2(0.6, -0.12)..multiply(size)));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // Do something
  }
}
