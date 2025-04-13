import 'package:flutter/material.dart';

import '../../presentation/screens/add_ad_screen.dart';
import '../../presentation/screens/ads_screen.dart';
import '../../presentation/screens/choose_login_register_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/main_screen.dart';
import '../../presentation/screens/notifications_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/register/RegisterScreen.dart';
import '../../presentation/screens/welcome_screen.dart';

mixin AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstants.initial:
        return _materialRoute(const WelcomeScreen());

      case RoutesConstants.screenChooseLoginRegister:
        return _materialRoute(const ChooseLoginRegisterScreen());

      case RoutesConstants.mainScreen:
        return _materialRoute(const MainScreen());

      case RoutesConstants.homeScreen:
        return _materialRoute(const HomeScreen());

      case RoutesConstants.adsScreen:
        return _materialRoute(const AdsScreen());

      case RoutesConstants.addAdScreen:
        return _materialRoute(const AddAdScreen());

      case RoutesConstants.notificationsScreen:
        return _materialRoute(const NotificationScreen());

      case RoutesConstants.profileScreen:
        return _materialRoute(const ProfileScreen());

      case RoutesConstants.loginScreen:
        return _materialRoute(const LoginScreen());

      case RoutesConstants.registerScreen:
        return _materialRoute(const RegisterScreen());

      default:
        return _materialRoute(
          const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

class RoutesConstants {
  static const initial = "/";
  static const welcome = "/ScreenWelcome";
  static const screenChooseLoginRegister = "/ScreenChooseLoginRegister";
  static const mainScreen = "/MainScreen";
  static const homeScreen = "/HomeScreen";
  static const adsScreen = "/AdsScreen";
  static const addAdScreen = "/AddAdScreen";
  static const notificationsScreen = "/NotificationsScreen";
  static const profileScreen = "/ProfileScreen";
  static const loginScreen = "/LoginScreen";
  static const registerScreen = "/RegisterScreen";
}
