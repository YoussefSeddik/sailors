class SettingItem {
  final String? iconPath;
  final String leadingTitleKey;
  final String? tailingTitleKey;
  final SettingItemType type;

  SettingItem(
    this.iconPath,
    this.leadingTitleKey,
    this.type, {
    this.tailingTitleKey,
  });
}

enum SettingItemType {
  editProfile,
  changePassword,
  complaints,
  contactUs,
  aboutApp,
  changeLanguage,
}
