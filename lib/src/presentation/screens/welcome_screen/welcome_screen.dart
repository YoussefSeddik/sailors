import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailors/src/config/routes/app_routes.dart';
import 'package:sailors/src/presentation/screens/welcome_screen/welcome_bloc.dart';
import 'package:sailors/src/presentation/screens/welcome_screen/welcome_event.dart';
import 'package:sailors/src/presentation/screens/welcome_screen/welcome_states.dart';

import '../../../core/utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: welcomeDurationInMillis),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleNavigation(BuildContext context, WelcomeState state) {
    if (state is NavigateToLogin) {
      Navigator.pushReplacementNamed(context, RoutesConstants.loginScreen);
    } else if (state is NavigateToMain) {
      Navigator.pushReplacementNamed(context, RoutesConstants.mainScreen);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(),
      child: Builder(
        builder: (context) {
          Future.delayed(
            const Duration(milliseconds: welcomeDurationInMillis),
                () {
              context.read<WelcomeBloc>().add(CheckAuthEvent());
            },
          );
          return BlocListener<WelcomeBloc, WelcomeState>(
            listener: _handleNavigation,
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              body: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('images/ic_logo.png', fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
