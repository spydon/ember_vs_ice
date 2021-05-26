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
    final head = HitboxCircle(definition: 0.6)
      ..relativeOffset = Vector2(-0.12, -0.5);
    final body = HitboxPolygon([
      Vector2(-0.5,-0.5),
      Vector2(-0.9,0.60),
      Vector2(0.6,0.6),
      Vector2(0.7,0.2),
      Vector2(0.5,-0.5),
    ])..relativeOffset = Vector2(-0.12, 0.4);
    addShape(body);
    addShape(head);
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
