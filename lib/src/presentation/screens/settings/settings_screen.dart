import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/fonts/app_text_styles.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/widgets/sailors_app_bar.dart';
import '../../../widgets/setting_tile.dart';
import '../../models/setting_item.dart';
import 'settings_bloc.dart';
import 'settings_event.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return BlocProvider(
      create: (_) => GetIt.I<SettingsBloc>()..add(LoadContent()),
      child: Scaffold(
        appBar: SailorsAppBar(title: 'settings'.tr(), showBackButton: true),
        body: BlocBuilder<SettingsBloc, BaseState<void>>(
          builder: (context, state) {
            final items =
                state is SuccessState<List<SettingItem>>
                    ? state.data ?? []
                    : [];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  ...items.map((e) => SettingTile(item: e)),

                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: AppColors.color_51AACC),
                    ),
                    child: Text('delete_account'.tr()),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'logout'.tr(),
                    style: AppTextStyles.bold.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/facebook_icon.svg', width: 22),
                      const SizedBox(width: 10),
                      SvgPicture.asset('images/tiktok_icon.svg', width: 22),
                      const SizedBox(width: 6),
                      SvgPicture.asset('images/whatsapp_icon.svg', width: 24),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'v1.0.0',
                    style: AppTextStyles.regular.copyWith(
                      color: AppColors.color_CCCCCC,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
