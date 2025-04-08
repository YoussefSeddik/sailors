import 'package:flutter/material.dart';
import 'package:sailors/src/core/utils/dimens_constants.dart';

import '../../core/utils/colors_constants.dart';

mixin AppTheme {
  static ThemeData get light {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        hintColor: ColorsConstant.kAccentColor,
        splashColor: Colors.transparent,
        textTheme: _buildTextTheme(base.textTheme));
  }

  static _buildTextTheme(TextTheme textTheme) =>
      textTheme.copyWith(
        bodySmall: const TextStyle(fontSize: DimensConstants.kDimens_12,fontWeight: FontWeight.w400),

      ).apply(
        fontFamily: 'Tajawal',
      );
}
