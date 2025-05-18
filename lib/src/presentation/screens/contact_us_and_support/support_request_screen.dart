import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailors/src/presentation/screens/contact_us_and_support/support_bloc.dart';
import 'package:sailors/src/presentation/screens/contact_us_and_support/support_event.dart';

import '../../../core/bloc/base_state.dart';
import '../../../data/models/params/support_params.dart';
import '../../../injector.dart';
import '../../../widgets/loading_overlay.dart';
import '../../../widgets/text_field.dart';

class SupportRequestScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  SupportRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<SupportBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('support_or_suggestions'.tr())),
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
                  children: [
                    buildTextField(
                      hintKey: 'title_hint',
                      controller: titleController,
                    ),
                    const SizedBox(height: 12),
                    buildTextField(hintKey: 'name', controller: nameController),
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
                              final params = SupportRequestParams(
                                title: titleController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                details: messageController.text,
                              );
                              context.read<SupportBloc>().add(
                                SendSupportEvent(params),
                              );
                            },
                            child: Text('send'.tr()),
                          ),
                        ),
                      ],
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
