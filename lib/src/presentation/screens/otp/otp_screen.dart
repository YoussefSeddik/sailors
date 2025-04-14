import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/bloc/base_state.dart';
import '../../../injector.dart';
import 'otp_bloc.dart';
import 'otp_event.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<OtpBloc>(),
      child: const _OtpView(),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView();

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Text(
                'otp_title'.tr(),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(color: colorScheme.onBackground),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              BlocConsumer<OtpBloc, BaseState<void>>(
                listener: (context, state) {
                  if (state is SuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('otp_verified_success'.tr())),
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
                      context.read<OtpBloc>().add(OtpSubmitted(_otp));
                    },
                    child:
                        state is LoadingState
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Text('otp_confirm'.tr()),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<OtpBloc, BaseState<void>>(
                builder: (context, state) {
                  final bloc = context.read<OtpBloc>();
                  final enabled = bloc.secondsRemaining == 0;
                  return TextButton(
                    onPressed:
                        enabled ? () => bloc.add(OtpResendRequested()) : null,
                    child: Text(
                      enabled
                          ? 'otp_resend'.tr()
                          : 'otp_resend_wait'.tr(
                            args: ['${bloc.secondsRemaining}'],
                          ),
                      style: TextStyle(
                        color:
                            enabled
                                ? colorScheme.primary
                                : colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
