import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../config/routes/app_routes.dart';
import '../config/themes/app_colors.dart';
import '../config/themes/fonts/app_text_styles.dart';
import '../presentation/models/otp_result_model.dart';
import '../presentation/models/setting_item.dart';
import '../presentation/screens/settings/settings_bloc.dart';
import '../presentation/screens/settings/settings_event.dart';

class SettingTile extends StatelessWidget {
  final SettingItem item;

  const SettingTile({super.key, required this.item});

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
        onTap: () async {
          switch (item.type) {
            case SettingItemType.editProfile:
              // Navigate or perform action
              break;
            case SettingItemType.changePassword:
              final result =
                  await Navigator.pushNamed<OtpResult>(
                context,
                RoutesConstants.otpScreen,
              );

              if (result != null && result.verified) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesConstants.changePasswordScreen,
                      (route) => false,
                );
              }
              break;
            case SettingItemType.complaints:
              // Open complaint form
              break;
            case SettingItemType.contactUs:
              // Launch contact us
              break;
            case SettingItemType.aboutApp:
              // Show about app screen
              break;
            case SettingItemType.changeLanguage:
              final newLocale =
                  context.locale.languageCode == 'ar'
                      ? const Locale('en')
                      : const Locale('ar');
              context.setLocale(newLocale).then((_) {
                context.setLocale(newLocale).then((_) {
                  // Trigger reload after locale change
                  context.read<SettingsBloc>().add(LoadContent());
                });
              });
              break;
          }
        },
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
  }
}
