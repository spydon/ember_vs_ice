import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import '../1_basic_setup/player.dart';
import 'ember2.dart';

class Player2 extends Player with Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxRectangle());
  }

  @override
  PositionComponent createEmber() {
    return Ember2(position + (Vector2(0.6, -0.12)..multiply(size)));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    print('$this collided $other');
  }
}
