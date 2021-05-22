import 'package:ember_vs_ice/1_basic_setup/ember_game.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'ice_cube3.dart';
import 'player3.dart';

class EmberGame3 extends EmberGame with HasCollidables {
  @override
  bool debugMode = false;

  @override
  PositionComponent createPlayer() => Player3();

  @override
  PositionComponent createEnemy() {
    return IceCube3(Vector2(size.x + 100, rng.nextDouble() * size.y));
  }
}
