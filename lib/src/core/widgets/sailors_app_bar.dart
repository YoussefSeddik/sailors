import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SailorsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBackButton;
  final Widget? trailingIconWidget;
  final VoidCallback? onTrailingPressed;

  const SailorsAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showBackButton = true,
    this.trailingIconWidget,
    this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton ? const BackButton() : null,
      title: Text(
        title.tr(),
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      centerTitle: centerTitle,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      foregroundColor: Colors.black,
      actions:
          trailingIconWidget != null
              ? [
                IconButton(
                  icon: trailingIconWidget!,
                  onPressed: onTrailingPressed,
                ),
              ]
              : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
