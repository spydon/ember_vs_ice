import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '1_basic_setup/ember_game.dart';
import '2_collidable/ember_game2.dart';
import '3_hitboxes//ember_game3.dart';
import '4_result/ember_game4.dart';

void main() async {
  final dashbook = Dashbook(
    title: 'Collision detection showcase',
    theme: ThemeData.dark(),
  );

  dashbook.storiesOf('Step-by-step')
    ..add(
      'Basic setup',
      (_) => GameWidget(game: EmberGame()),
      codeLink: baseLink('1_basic_setup'),
    )
    ..add(
      'Collidable mixin',
      (_) => GameWidget(game: EmberGame2()),
      codeLink: baseLink('2_collidable'),
    )
    ..add(
      'Add hitboxes',
      (_) => GameWidget(game: EmberGame3()),
      codeLink: baseLink('3_hitboxes'),
    )
    ..add(
      'Finalized result',
      (_) => GameWidget(game: EmberGame4()),
      codeLink: baseLink('4_result'),
    );
  runApp(dashbook);
}

String baseLink(String path) {
  const _basePath = 'https://github.com/spydon/ember_vs_ice/blob/main/lib/';

  return '$_basePath$path';
}
