import 'dart:ui';

import 'package:ember_vs_ice/4_result/ember_game4.dart';
import 'package:ember_vs_ice/4_result/restart_button.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flame/widgets.dart';

import 'score_text.dart';

class GameOver extends PositionComponent with HasGameRef<EmberGame4> {
  @override
  int priority = 5;
  final Score scoreComponent;
  late final TextComponent gameOverText;
  bool isShowing = false;

  GameOver(this.scoreComponent);

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    isHud = true;
    final textRenderer = TextPaint(
      config: TextPaintConfig(
        color: BasicPalette.white.color,
      ),
    );
    gameOverText = TextComponent("Game over", textRenderer: textRenderer)
      ..anchor = Anchor.center;
    addChild(RestartButton());
  }

  @override
  void render(Canvas canvas) {
    if (!isShowing) return;
    super.render(canvas);
    gameOverText.render(canvas);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
  }

  void show() {
    isShowing = true;
    scoreComponent.moveDown();
  }

  void hide() {
    isShowing = false;
    scoreComponent.moveUp();
  }
}
