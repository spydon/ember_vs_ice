import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/rendering.dart';

class Background extends ParallaxComponent with HasGameRef<BaseGame> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(['bg1.png', 'bg2.png'],
        baseVelocity: Vector2(50, -20),
        velocityMultiplierDelta: Vector2(1.8, 1.2),
        repeat: ImageRepeat.repeat);
  }
}
