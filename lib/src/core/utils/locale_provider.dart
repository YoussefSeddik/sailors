import 'package:flutter/material.dart';

class LocaleProvider {
  Locale Function() getLocale;

  LocaleProvider({required this.getLocale});
}
