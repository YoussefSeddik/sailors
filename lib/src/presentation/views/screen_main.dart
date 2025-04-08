import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:sailors/src/presentation/views/screen_add_ad.dart';
import 'package:sailors/src/presentation/views/screen_ads.dart';
import 'package:sailors/src/presentation/views/screen_home.dart';
import 'package:sailors/src/presentation/views/screen_notifications.dart';
import 'package:sailors/src/presentation/views/screen_profile.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ScreenHome(),
    ScreenAds(),
    ScreenAddAd(),
    ScreenNotification(),
    ScreenProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: Scaffold(
              body: _screens[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: isDark ? Colors.tealAccent : Colors.blue,
                unselectedItemColor: isDark ? Colors.grey[400] : Colors.grey,
                backgroundColor: Theme.of(context).colorScheme.surface,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: 'nav_home'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.store),
                    label: 'nav_ads'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.add_a_photo),
                    label: 'nav_add_ad'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.notifications),
                    label: 'nav_notifications'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: 'nav_profile'.tr(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
