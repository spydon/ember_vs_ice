import 'dart:ui';

import 'package:ember_vs_ice/4_result/ember_game4.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';

class RestartButton extends SpriteComponent
    with HasGameRef<EmberGame4>, Tapable {
  @override
  int priority = 5;
  late final TextPaint _textRenderer;
  final Paint _backgroundPaint = BasicPalette.blue.paint()..style = PaintingStyle.stroke;

  RestartButton() : super();

  @override
  Future<void> onLoad() async {
    isHud = true;
    position = Vector2(0, 80);
    size = Vector2(150, 50);
    anchor = Anchor.center;
    _textRenderer =
      TextPaint(
        config: TextPaintConfig(
          color: BasicPalette.white.color,
        ),
      );
  }

  @override
  void render(Canvas canvas) {
    if(!gameRef.isGameOver) return;
    super.render(canvas);
    canvas.drawRect(size.toRect(), _backgroundPaint);
    _textRenderer.render(canvas, "Restart", size / 2, anchor: anchor);
  }

  @override
  bool onTapDown(TapDownInfo _) {
    addEffect(ScaleEffect(size: size - Vector2.all(10), duration: 0.2));
    return false;
  }

  @override
  bool onTapUp(TapUpInfo _) {
    addEffect(ScaleEffect(size: size + Vector2.all(10), duration: 0.2, onComplete: gameRef.restart,));
    return false;
  }

  @override
  bool onTapCancel() {
    gameRef.restart();
    return false;
  }
}
