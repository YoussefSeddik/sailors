import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/bloc/base_state.dart';
import '../../../injector.dart';
import 'login_bloc.dart';
import 'login_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => injector<LoginBloc>(),
      child: Scaffold(
        body: SafeArea(
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
                        'login'.tr(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                        onTap: () {},
                        child: Text(
                          'forgot_password'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF51AACC),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocConsumer<LoginBloc, BaseState<void>>(
                      listener: (context, state) {
                        if (state is SuccessState) {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesConstants.mainScreen,
                          );
                        } else if (state case FailureState(:final message)) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF51AACC),
                          ),
                          child:
                              state is LoadingState
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text('login'.tr()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'no_account'.tr(),
                          children: [
                            TextSpan(
                              text: 'register'.tr(),
                              style: const TextStyle(color: Color(0xFF51AACC)),
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
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF51AACC)),
                      ),
                      child: Text(
                        'guest_login'.tr(),
                        style: const TextStyle(color: Color(0xFF51AACC)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
