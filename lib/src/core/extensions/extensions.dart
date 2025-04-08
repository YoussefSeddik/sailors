import 'package:flutter/cupertino.dart';

import '../../config/localization/app_localizations.dart';

extension Translator on BuildContext {
  String translate(String key) {
    return AppLocalizations.of(this).translate(key);
  }

}
