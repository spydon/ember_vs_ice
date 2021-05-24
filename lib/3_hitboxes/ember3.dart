import 'package:ember_vs_ice/1_basic_setup/ember.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

class Ember3 extends Ember with Hitbox, Collidable {
  Ember3(Vector2 position, double direction) : super(position, direction);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxCircle());
    collidableType = CollidableType.passive;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    print('$this collided $other');
  }
}
