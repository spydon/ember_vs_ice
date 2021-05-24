import 'dart:math';

import 'package:ember_vs_ice/4_result/game_over.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'ice_cube4.dart';
import 'player4.dart';

import 'background.dart';
import 'score_text.dart';

class EmberGame4 extends BaseGame
    with HasDraggableComponents, HasTapableComponents, HasCollidables {
  final Random rng = Random();
  late final GameOver gameOverComponent;
  late PositionComponent player;
  static const _startSpawnRate = 15.0;
  double spawnRate = _startSpawnRate;
  double _spawnTime = 0;
  bool isGameOver = false;
  int score = 0;

  @override
  Future<void> onLoad() async {
    final score = Score(Vector2(size.x / 2, 30));
    gameOverComponent = GameOver(score);
    add(Background());
    add(gameOverComponent);
    add(score);
    addPlayer();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameOverComponent.isShowing) return;

    if (isGameOver) {
      gameOver();
    } else {
      _spawnTime -= dt;
      if (_spawnTime <= 0 && components.length < 15) {
        add(createEnemy());
        _spawnTime = spawnRate;
      }
    }
  }

  PositionComponent createEnemy() {
    return IceCube4(Vector2(size.x + 100, rng.nextDouble() * size.y));
  }

  void addPlayer() {
    player = Player4();
    add(player);
  }

  void gameOver() {
    gameOverComponent.show();
    components.whereType<IceCube4>().forEach((enemy) {
      enemy.shrink(Vector2.zero());
    });
  }

  void restart() {
    gameOverComponent.hide();
    spawnRate = _startSpawnRate;
    _spawnTime = 0.0;
    score = 0;
    isGameOver = false;
    addPlayer();
  }
}
