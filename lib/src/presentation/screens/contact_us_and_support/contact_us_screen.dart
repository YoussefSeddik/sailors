import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailors/src/presentation/screens/contact_us_and_support/support_bloc.dart';
import 'package:sailors/src/presentation/screens/contact_us_and_support/support_event.dart';

import '../../../core/bloc/base_state.dart';
import '../../../data/models/params/send_contact_us_params.dart';
import '../../../injector.dart';
import '../../../widgets/loading_overlay.dart';
import '../../../widgets/text_field.dart';

class ContactUsScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<SupportBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('contact_us'.tr())),
        body: BlocConsumer<SupportBloc, BaseState<void>>(
          listener: (context, state) {
            if (state is SuccessState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('success'.tr())));
              Navigator.of(context).pop();
            } else if (state is FailureState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final isLoading = state is LoadingState;
            return LoadingOverlay(
              isLoading: isLoading,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextField(hintKey: 'name', controller: nameController),
                    const SizedBox(height: 12),
                    buildTextField(
                      hintKey: 'email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 12),
                    buildTextField(
                      hintKey: 'phone',
                      controller: phoneController,
                    ),
                    const SizedBox(height: 12),
                    buildTextField(
                      hintKey: 'how_can_we_help',
                      controller: messageController,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final params = ContactUsParams(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                details: messageController.text,
                              );
                              context.read<SupportBloc>().add(
                                SendContactUsEvent(params),
                              );
                            },
                            child: Text('send'.tr()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'or_contact_us_through'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text('email_label'.tr()),
                    Text('phone_label'.tr()),
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
