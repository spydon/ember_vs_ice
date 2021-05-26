import 'package:ember_vs_ice/4_result/ember_game4.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/animation.dart';

class Score extends TextComponent with HasGameRef<EmberGame4> {
  static const String _baseText = "Score:";
  Vector2 topPosition;
  int _score = 0;
  @override
  int priority = 5;

  Score(this.topPosition) : super("$_baseText 0");

  @override
  Future<void> onLoad() async {
    position = topPosition.clone();
    isHud = true;
    textRenderer = TextPaint(
      config: TextPaintConfig(
        color: BasicPalette.white.color,
        fontFamily: 'Inconsolata',
      ),
    );
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.score != _score) {
      _score = gameRef.score;
      text = "$_baseText $_score";
    }
  }

  void moveDown() {
    addEffect(MoveEffect(
      path: [gameRef.size / 2 + Vector2(0, 30)],
      speed: 300,
      curve: Curves.bounceIn,
    ));
  }

  void moveUp() {
    addEffect(MoveEffect(
      path: [topPosition],
      speed: 300,
      curve: Curves.bounceOut,
    ));
  }
}
