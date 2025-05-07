import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_bloc.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_event.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/themes/app_theme.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/widgets/sailors_app_bar.dart';
import '../../../injector.dart';
import '../../../widgets/loading_overlay.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (_) => injector<UpdatePasswordBloc>(),
      child: Scaffold(
        appBar: const SailorsAppBar(title: 'change_password'),
        body: SafeArea(
          child: BlocBuilder<UpdatePasswordBloc, BaseState<void>>(
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
                          const SizedBox(height: 12),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: 'new_password'.tr(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'confirm_password'.tr(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          BlocConsumer<UpdatePasswordBloc, BaseState<void>>(
                            listener: (context, state) {
                              if (state is SuccessState) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RoutesConstants.successfulStateScreen,
                                  arguments: 'password_changed_successfully'.tr(),
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
                                  context.read<UpdatePasswordBloc>().add(
                                    SubmitPassword(
                                      passwordController.text,
                                      confirmPasswordController.text,
                                    ),
                                  );
                                },
                                child: Text('save_data'.tr()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
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

class UpdatePasswordScreenPreview extends StatelessWidget {
  const UpdatePasswordScreenPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: UpdatePasswordScreen());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initializeDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'i18n',
      fallbackLocale: const Locale('en'),
      child: Builder(
        builder:
            (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: const UpdatePasswordScreen(),
            ),
      ),
    ),
  );
}
