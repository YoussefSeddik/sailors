enum SailorFont {
  light,
  regular,
  medium,
  bold,
  extraBold,
  black,
}

extension SailorFontFamily on SailorFont {
  String get family {
    switch (this) {
      case SailorFont.light:
        return 'SailorLight';
      case SailorFont.regular:
        return 'SailorRegular';
      case SailorFont.medium:
        return 'SailorMedium';
      case SailorFont.bold:
        return 'SailorBold';
      case SailorFont.extraBold:
        return 'SailorExtraBold';
      case SailorFont.black:
        return 'SailorBlack';
    }
  }
}

