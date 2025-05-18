import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/themes/app_colors.dart';
import '../config/themes/fonts/app_text_styles.dart';
import '../presentation/models/setting_item.dart';

class SettingTile extends StatelessWidget {
  final SettingItem item;
  final VoidCallback? onTap;

  const SettingTile({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLanguageItem = item.type == SettingItemType.changeLanguage;

    final trailingText =
        isLanguageItem
            ? (context.locale.languageCode == 'ar' ? 'English' : 'العربية').tr()
            : '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.color_F5F5F5,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            if (item.iconPath != null) ...[
              SvgPicture.asset(item.iconPath!, width: 20),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                item.leadingTitleKey.tr(),
                style: AppTextStyles.regular,
                textAlign: TextAlign.start,
              ),
            ),
            if (trailingText.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                trailingText,
                style: AppTextStyles.regular.copyWith(
                  color: AppColors.color_CCCCCC,
                ),
              ),
            ],
          ],
        ),
      ),
    );
    ;
  }
}
