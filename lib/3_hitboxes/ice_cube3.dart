import 'package:ember_vs_ice/1_basic_setup/ember.dart';
import 'package:ember_vs_ice/1_basic_setup/ice_cube.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';

class IceCube3 extends IceCube with Hitbox, Collidable {
  IceCube3(Vector2 position) : super(position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final rectangle = HitboxRectangle(relation: Vector2(1.0, 0.5))
      ..relativeOffset = Vector2(0.0, -0.5);
    addShape(rectangle);
    final circle = HitboxCircle()..relativeOffset = Vector2(0.0, 0.5);
    addShape(rectangle);
    addShape(circle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // Do something
  }
}
