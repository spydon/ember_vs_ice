import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../1_basic_setup/ice_cube.dart';

class IceCube2 extends IceCube with Hitbox, Collidable {
  IceCube2(Vector2 position) : super(position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addShape(HitboxRectangle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    print('$this collided $other');
  }
}
