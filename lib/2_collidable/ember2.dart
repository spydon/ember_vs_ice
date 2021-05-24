import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

import '../1_basic_setup/ember.dart';

class Ember2 extends Ember with Hitbox, Collidable {
  Ember2(Vector2 position, double direction) : super(position, direction);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxRectangle());
    collidableType = CollidableType.passive;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    print('$this collided $other');
  }
}
