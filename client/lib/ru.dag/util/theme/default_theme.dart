import 'dart:ui';

import 'package:client/ru.dag/util/theme/lets_play_theme.dart';
import 'package:flutter/material.dart';

class DefaultTheme implements LetsPlayTheme {
  @override
  Color firstColor() {
    return const Color(0xFFEB6440);
  }

  @override
  Color secondColor() {
    return const Color(0xFF497174);
  }

  @override
  Color thirdColor() {
    return const Color(0xFFD6E4E5);
  }

  @override
  Color fourthColor() {
    return const Color(0xFFEFF5F5);
  }
}
