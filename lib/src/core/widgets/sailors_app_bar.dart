import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SailorsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBackButton;

  const SailorsAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton ? const BackButton() : null,
      title: Text(
        title.tr(),
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      centerTitle: centerTitle,
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.black),
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
