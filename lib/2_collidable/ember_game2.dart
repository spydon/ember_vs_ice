import 'package:ember_vs_ice/1_basic_setup/ember_game.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'ice_cube2.dart';
import 'player2.dart';

class EmberGame2 extends EmberGame with HasCollidables {
  @override
  bool debugMode = true;

  @override
  PositionComponent createPlayer() => Player2();

  @override
  PositionComponent createEnemy() {
    return IceCube2(Vector2(size.x + 100, rng.nextDouble() * size.y));
  }
}
