import 'dart:ui';

import 'package:client/ru.dag/util/theme/lets_play_theme.dart';
import 'package:flutter/material.dart';

class DefaultTheme implements LetsPlayTheme {
  @override
  Color filterBtnColor() {
    return const Color(0xFFFD9800);
  }

  @override
  Color locationBtnColor() {
    return const Color(0xFF8B65A1);
  }

  @override
  Color mapTabColor() {
    return const Color(0xFF1D8AD3);
  }

  @override
  Color menuTabColor() {
    return const Color(0xFF24B9B4);
  }

  @override
  Color navBarColor() {
    return const Color(0xFFE5DC55);
  }

  @override
  Color navBarTransitionColor() {
    return const Color(0xFF24B93D);
  }

}
