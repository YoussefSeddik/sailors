import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/presentation/screens/forget_password/forget_password_event.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/bloc/base_state.dart';
import '../../../data/models/user_model.dart';
import '../../../injector.dart';
import '../../../widgets/loading_overlay.dart';
import '../../models/otp_result_model.dart';
import 'forget_password_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.onBackground;

    return BlocProvider(
      create: (_) => injector<ForgetPasswordBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ForgetPasswordBloc, BaseState<UserModel>>(
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
                              'forgot_password_without?'.tr(),
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
                          BlocConsumer<
                            ForgetPasswordBloc,
                            BaseState<UserModel>
                          >(
                            listener: (context, state) async {
                              if (state is SuccessState<UserModel>) {
                                final result =
                                    await Navigator.pushNamed<OtpResult>(
                                      context,
                                      RoutesConstants.otpScreen,
                                      arguments: state.data?.phone,
                                    );

                                if (result != null && result.verified) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutesConstants.changePasswordScreen,
                                    arguments: state.data?.phone,
                                    (route) => false,
                                  );
                                }
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
                                  context.read<ForgetPasswordBloc>().add(
                                    ForgetPassword(phoneController.text),
                                  );
                                },
                                child: Text('send_code'.tr()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'log_in'.tr(),
                                style: TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.none,
                                ),
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
