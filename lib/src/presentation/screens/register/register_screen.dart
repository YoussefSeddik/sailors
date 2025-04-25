import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/bloc/base_state.dart';
import '../../../injector.dart';
import '../../../widgets/loading_overlay.dart';
import 'register_bloc.dart';
import 'register_event.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => injector<RegisterBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<RegisterBloc, BaseState<void>>(
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
                              'register'.tr(),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(hintText: 'name'.tr()),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: 'phone_number'.tr(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'password'.tr(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          BlocConsumer<RegisterBloc, BaseState<void>>(
                            listener: (context, state) {
                              if (state is SuccessState) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesConstants.otpScreen,
                                );
                              } else if (state is FailureState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  context.read<RegisterBloc>().add(
                                    RegisterSubmitted(
                                      nameController.text,
                                      phoneController.text,
                                      passwordController.text,
                                    ),
                                  );
                                },
                                child: Text('register'.tr()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'already_have_an_account'.tr(),
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onBackground,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'log_in'.tr(),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap =
                                              () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
