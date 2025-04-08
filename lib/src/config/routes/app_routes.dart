import 'package:flutter/material.dart';

import '../../presentation/views/items_view.dart';
import '../../presentation/views/screen_choose_login_register.dart';
import '../../presentation/views/screen_login.dart';
import '../../presentation/views/screen_notifications.dart';
import '../../presentation/views/screen_welcome.dart';
import '../../presentation/views/screen_main.dart';
import '../../presentation/views/screen_home.dart';
import '../../presentation/views/screen_ads.dart';
import '../../presentation/views/screen_add_ad.dart';
import '../../presentation/views/screen_profile.dart';

mixin AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstants.initial:
        return _materialRoute(const SplashScreen());

      case RoutesConstants.screenChooseLoginRegister:
        return _materialRoute(const ScreenChooseLoginRegister());

      case RoutesConstants.items:
        return _materialRoute(const ItemsView());

      case RoutesConstants.screenMain:
        return _materialRoute(const ScreenMain());

      case RoutesConstants.screenHome:
        return _materialRoute(const ScreenHome());

      case RoutesConstants.screenAds:
        return _materialRoute(const ScreenAds());

      case RoutesConstants.screenAddAd:
        return _materialRoute(const ScreenAddAd());

      case RoutesConstants.screenNotification:
        return _materialRoute(const ScreenNotification());

      case RoutesConstants.screenProfile:
        return _materialRoute(const ScreenProfile());

      case RoutesConstants.screenLogin:
        return _materialRoute(const ScreenLogin());


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
  static const items = "/ItemsView";

  static const screenMain = "/ScreenMain";
  static const screenHome = "/ScreenHome";
  static const screenAds = "/ScreenAds";
  static const screenAddAd = "/ScreenAddAd";
  static const screenNotification = "/ScreenNotification";
  static const screenProfile = "/ScreenProfile";
  static const screenLogin = "/ScreenLogin";

}
