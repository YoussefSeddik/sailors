import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:sailors/src/presentation/screens/profile_screen.dart';
import 'add_ad_screen.dart';
import 'ads_screen.dart';
import 'home_screen.dart';
import 'notifications_screen.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    AdsScreen(),
    AddAdScreen(),
    NotificationScreen(),
    ProfileScreen(),
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
                    label: 'home'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.store),
                    label: 'my_ads'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.add_a_photo),
                    label: 'add_ad'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.notifications),
                    label: 'notifications'.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: 'profile'.tr(),
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
