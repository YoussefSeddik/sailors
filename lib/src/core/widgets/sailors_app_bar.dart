import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/config/themes/fonts/app_text_styles.dart';

class SailorsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBackButton;
  final List<Widget>? trailing;

  const SailorsAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showBackButton = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      leading: showBackButton ? const BackButton() : null,
      title: Text(
        title.tr(),
        style: AppTextStyles.bold.copyWith(
          fontSize: 18,
          color: theme.colorScheme.onSurface,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: theme.colorScheme.background,
      elevation: 0,
      iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      foregroundColor: theme.colorScheme.onSurface,
      actions: trailing,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
