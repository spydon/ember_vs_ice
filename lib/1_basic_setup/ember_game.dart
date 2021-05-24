import 'dart:math';

import 'package:ember_vs_ice/1_basic_setup/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'background.dart';
import 'ice_cube.dart';

class EmberGame extends BaseGame with HasDraggableComponents {
  final Random rng = Random();
  late final PositionComponent player;
  double spawnRate = 15.0;
  double _spawnTime = 0;

  @override
  Future<void> onLoad() async {
    player = createPlayer();
    add(Background());
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawnTime -= dt;
    if (_spawnTime <= 0) {
      add(createEnemy());
      _spawnTime = spawnRate;
    }
  }

  PositionComponent createPlayer() => Player();

  PositionComponent createEnemy() {
    return IceCube(Vector2(size.x + 100, rng.nextDouble() * size.y));
  }
}
