import 'dart:ui';

import 'package:sailors/src/core/bloc/base_state.dart';
import 'package:sailors/src/core/bloc/bloc_with_state.dart';
import 'package:sailors/src/presentation/models/setting_item.dart';
import 'package:sailors/src/presentation/screens/settings/settings_event.dart';

import '../../../core/utils/locale_provider.dart';
import '../../../domain/usecaes/app_usecase.dart';

class SettingsBloc extends BlocWithState<SettingEvent, BaseState<void>> {
  final AppUseCases appUseCases;
  final LocaleProvider localeProvider;

  SettingsBloc(this.appUseCases, this.localeProvider) : super(InitialState()) {
    on<LoadContent>((event, emit) async {
      emit(SuccessState<List<SettingItem>>(_settingContent));
    });
  }

  List<SettingItem> get _settingContent {
    final isArabic = localeProvider.getLocale().languageCode == 'ar';

    return [
      SettingItem(
        'images/settings_profile_icon.svg',
        'edit_profile',
        SettingItemType.editProfile,
      ),
      SettingItem(
        'images/settings_change_password_icon.svg',
        'change_password',
        SettingItemType.changePassword,
      ),
      SettingItem(
        'images/settings_report_icon.svg',
        'complaints',
        SettingItemType.complaints,
      ),
      SettingItem(
        'images/settings_contact_us_icon.svg',
        'contact_us',
        SettingItemType.contactUs,
      ),
      SettingItem(
        'images/settings_about_app_icon.svg',
        'about_app',
        SettingItemType.aboutApp,
      ),
      SettingItem(
        null,
        'change_language',
        SettingItemType.changeLanguage,
        tailingTitleKey: isArabic ? 'language_en' : 'language_ar',
      ),
    ];
  }
}
