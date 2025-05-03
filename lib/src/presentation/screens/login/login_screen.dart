import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/bloc/base_state.dart';
import '../../../injector.dart';
import '../../../widgets/loading_overlay.dart';
import 'login_bloc.dart';
import 'login_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.onBackground;

    return BlocProvider(
      create: (_) => injector<LoginBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<LoginBloc, BaseState<void>>(
            builder: (context, state) {
              final isLoading = state is LoadingState;

              return LoadingOverlay(
                isLoading: isLoading,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 200),
                          Center(
                            child: Text(
                              'log_in'.tr(),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: 'phone_number'.tr(),
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'password'.tr(),
                              prefixIcon: const Icon(Icons.visibility_outlined),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesConstants.forgetPasswordScreen,
                                );
                              },
                              child: Text(
                                'forgot_password'.tr(),
                                style: TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          BlocConsumer<LoginBloc, BaseState<void>>(
                            listener: (context, state) {
                              if (state is SuccessState) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RoutesConstants.mainScreen,
                                  (route) => false,
                                );
                              } else if (state case FailureState(
                                :final message,
                              )) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    LoginSubmitted(
                                      phoneController.text,
                                      passwordController.text,
                                    ),
                                  );
                                },
                                child: Text('log_in'.tr()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'dont_have_an_account'.tr(),
                                style: TextStyle(color: textColor),
                                children: [
                                  TextSpan(
                                    text: 'register'.tr(),
                                    style: TextStyle(color: primaryColor),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                              context,
                                              RoutesConstants.registerScreen,
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesConstants.mainScreen,
                                (route) => false,
                              );
                            },
                            child: Text(
                              'as_a_guest'.tr(),
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
