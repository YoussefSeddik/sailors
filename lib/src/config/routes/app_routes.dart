import 'package:flutter/material.dart';
import 'package:sailors/src/presentation/screens/otp/otp_screen.dart';

import '../../presentation/models/otp_result_model.dart';
import '../../presentation/screens/add_ad_screen.dart';
import '../../presentation/screens/ads_screen.dart';
import '../../presentation/screens/forget_password/forget_password_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/main_screen.dart';
import '../../presentation/screens/notifications_screen.dart';
import '../../presentation/screens/profile_screen/profile_screen.dart';
import '../../presentation/screens/register/register_screen.dart';
import '../../presentation/screens/successful_state_screen.dart';
import '../../presentation/screens/update_password_screen/update_password_screen.dart';
import '../../presentation/screens/welcome_screen/welcome_screen.dart';

mixin AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstants.initial:
        return _materialRoute(const WelcomeScreen());

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

      case RoutesConstants.otpScreen:
        final message = settings.arguments as String? ?? '';
        return _materialRoute<OtpResult>(OtpScreen(phone: message));

      case RoutesConstants.successfulStateScreen:
        final message = settings.arguments as String? ?? '';
        return _materialRoute(SuccessfulStateScreen(message: message));

      case RoutesConstants.forgetPasswordScreen:
        return _materialRoute(const ForgetPasswordScreen());

      case RoutesConstants.changePasswordScreen:
        return _materialRoute(const UpdatePasswordScreen());

      default:
        return _materialRoute(
          const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }

  static Route<T> _materialRoute<T>(Widget view) {
    return MaterialPageRoute<T>(builder: (_) => view);
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
  static const otpScreen = "/OtpScreen";
  static const successfulStateScreen = "/SuccessfulStateScreen";
  static const forgetPasswordScreen = "/ForgetPasswordScreen";
  static const changePasswordScreen = "/ChangePasswordScreen";
}
