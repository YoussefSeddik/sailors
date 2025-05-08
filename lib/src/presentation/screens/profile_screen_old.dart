import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('screen_profile'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('language'.tr(), style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.setLocale(const Locale('en')),
                  child: const Text('🇺🇸 English'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => context.setLocale(const Locale('ar')),
                  child: const Text('🇪🇬 العربية'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('theme_mode'.tr(), style: const TextStyle(fontSize: 18)),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (val) => themeProvider.toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
