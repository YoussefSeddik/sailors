import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sailors/src/presentation/screens/create_advertise_screen/create_advertise_screen.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_ads_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_screen.dart';
import '../../config/themes/app_theme.dart';
import '../../core/widgets/svg_nav_icon.dart';
import '../../injector.dart';
import 'create_advertise_screen/create_advertise_bloc.dart';
import 'create_advertise_screen/create_advertise_event.dart';
import 'home_screen.dart';
import 'my_ads/my_ads_screen.dart';
import 'notifications/notifications_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  final List<Widget> _screens = [
    HomeScreen(),
    BlocProvider(
      create: (_) => injector<ProfileAdsBloc>(),
      child: MyAdsScreen(),
    ),
    SizedBox(),
    const NotificationsScreen(),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<ProfileBloc>()..add(LoadProfile())),
        BlocProvider(create: (_) => injector<ProfileAdsBloc>()),
      ],
      child: ProfileScreen(),
    ),
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
          return Theme(
            data:
                themeProvider.themeMode == ThemeMode.dark
                    ? AppTheme.darkTheme
                    : AppTheme.lightTheme,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Scaffold(
                  body: _screens[_selectedIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        if (index == 2) {
                          return;
                        }
                        _selectedIndex = index;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: isDark ? Colors.tealAccent : Colors.blue,
                    unselectedItemColor:
                        isDark ? Colors.grey[400] : Colors.grey,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    items: [
                      BottomNavigationBarItem(
                        icon: ThemedSvgIcon(
                          assetPath: 'images/home_icon.svg',
                          color: _getNavIconColor(0, isDark),
                        ),
                        label: 'home'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: ThemedSvgIcon(
                          assetPath: 'images/ad_icon.svg',
                          color: _getNavIconColor(1, isDark),
                        ),
                        label: 'my_ads'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: IgnorePointer(
                          ignoring: true,
                          child: SizedBox(width: 24, height: 24),
                        ),
                        label: 'add_ad'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: ThemedSvgIcon(
                          assetPath: 'images/notification_icon.svg',
                          color: _getNavIconColor(3, isDark),
                        ),
                        label: 'notifications'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: ThemedSvgIcon(
                          assetPath: 'images/profile_icon.svg',
                          color: _getNavIconColor(4, isDark),
                        ),
                        label: 'profile'.tr(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider(
                                create:
                                    (_) =>
                                        injector<CreateAdvertiseBloc>()
                                          ..add(FetchScreenData()),
                                child: const CreateAdvertiseScreen(),
                              ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: SvgPicture.asset('images/add_ad_icon.svg'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getNavIconColor(int index, bool isDark) {
    final isSelected = _selectedIndex == index;
    if (isSelected) {
      return isDark ? Colors.tealAccent : Colors.blue;
    } else {
      return isDark ? Colors.grey[400]! : Colors.grey;
    }
  }
}
