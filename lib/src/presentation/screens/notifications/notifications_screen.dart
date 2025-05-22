import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailors/src/core/widgets/sailors_app_bar.dart';
import 'package:sailors/src/core/bloc/base_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/data/models/notification_model.dart';
import 'package:sailors/src/widgets/loading_overlay.dart';
import '../../../injector.dart';
import 'notification_bloc.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<NotificationBloc>()..add(FetchNotifications()),
      child: Scaffold(
        appBar: SailorsAppBar(
          title: 'notifications'.tr(),
          showBackButton: false,
        ),
        body: SafeArea(
          child: BlocBuilder<
            NotificationBloc,
            BaseState<List<NotificationModel>>
          >(
            builder: (context, state) {
              final isLoading = state is LoadingState;

              final notifications =
                  state is SuccessState<List<NotificationModel>>
                      ? state.data ?? []
                      : <NotificationModel>[];

              return LoadingOverlay(
                isLoading: isLoading,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox.expand(
                    child: Column(
                      children: [
                        Expanded(
                          child:
                              notifications.isNotEmpty
                                  ? ListView.separated(
                                    itemCount: notifications.length,
                                    separatorBuilder:
                                        (_, __) => const SizedBox(height: 12),
                                    itemBuilder: (_, i) {
                                      final item = notifications[i];
                                      return ListTile(
                                        leading:
                                            item.image != null
                                                ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    item.image!,
                                                    width: 48,
                                                    height: 48,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                                : const Icon(
                                                  Icons.notifications,
                                                ),
                                        title: Text(item.title ?? ''),
                                        subtitle: Text(item.desc ?? ''),
                                      );
                                    },
                                  )
                                  : state
                                      is SuccessState<List<NotificationModel>>
                                  ? Center(
                                    child: Text(
                                      'no_notifications'.tr(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onBackground,
                                      ),
                                    ),
                                  )
                                  : const SizedBox.shrink(),
                        ),
                      ],
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
