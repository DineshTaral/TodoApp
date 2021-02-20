import 'package:flutter/material.dart';

class ColorsConstants{

  static final WHITE_TEXT_COLOR=Color(0xffffffff);
  static final WHITE_ICON_COLOR=Color(0xffffffff);
  static final BACKGROUND_COLOR=Color(0xff9FE5C9);

  static LinearGradient LINEAR_GRADIENT1=LinearGradient(
      colors: [
        const Color(0xFF3366FF),
        const Color(0xFF00CCFF),
      ],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
  static LinearGradient LINEAR_GRADIENT2=LinearGradient(
      colors: [
       Colors.grey,
        Colors.white54
      ],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);


}