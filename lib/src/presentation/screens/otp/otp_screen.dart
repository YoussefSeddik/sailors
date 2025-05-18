import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/config/themes/app_colors.dart';
import 'package:sailors/src/widgets/loading_overlay.dart';
import '../../../core/bloc/base_state.dart';
import '../../../injector.dart';
import '../../models/otp_result_model.dart';
import 'otp_bloc.dart';
import 'otp_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/config/themes/app_colors.dart';
import 'package:sailors/src/widgets/loading_overlay.dart';
import '../../../core/bloc/base_state.dart';
import '../../../injector.dart';
import '../../models/otp_result_model.dart';
import 'otp_bloc.dart';
import 'otp_event.dart';

class OtpScreen extends StatelessWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<OtpBloc>()..add(StartTimer()),
      child: _OtpView(phone: phone),
    );
  }
}

class _OtpView extends StatefulWidget {
  final String phone;

  const _OtpView({required this.phone});

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OtpBloc, BaseState<void>>(
          builder: (BuildContext context, BaseState<void> state) {
            final isLoading = state is LoadingState;
            return LoadingOverlay(
              isLoading: isLoading,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 200),
                    Center(
                      child: Text(
                        'confirm_phone_number'.tr(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: 65,
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: const InputDecoration(counterText: ''),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < 3) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(_focusNodes[index + 1]);
                                } else {
                                  FocusScope.of(context).unfocus();
                                }
                              } else if (index > 0) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[index - 1]);
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    BlocConsumer<OtpBloc, BaseState<void>>(
                      listener: (context, state) {
                        if (state is SuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('verified_successfully'.tr()),
                            ),
                          );
                          Navigator.pop(
                            context,
                            OtpResult(
                              phoneNumber: widget.phone,
                              verified: true,
                            ),
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
                            context.read<OtpBloc>().add(
                              OtpSubmitted(_otp, widget.phone),
                            );
                          },
                          child: Text('confirm'.tr()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<OtpBloc, BaseState<void>>(
                      builder: (context, state) {
                        final bloc = context.read<OtpBloc>();
                        final secondsRemaining =
                            state is TickState
                                ? state.secondsRemaining
                                : bloc.secondsRemaining;

                        final enabled = secondsRemaining == 0;

                        return TextButton(
                          onPressed:
                              enabled ? () => bloc.add(OtpResendRequested(widget.phone)) : null,
                          child: enabled
                                  ? Text(
                                    'send_again'.tr(),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  )
                                  : Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Send again in '.tr(),
                                          style: TextStyle(
                                            color: AppColors.color_grey_dark,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'remaining_seconds'.tr(
                                            args: ['$secondsRemaining'],
                                          ),
                                          style: TextStyle(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
