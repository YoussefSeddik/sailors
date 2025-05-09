import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_ads_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/widgets/safe_network_image.dart';
import '../../../data/models/ad_model.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/loading_overlay.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<ProfileBloc>()..add(LoadProfile())),
        BlocProvider(
          create: (_) => GetIt.I<ProfileAdsBloc>()..add(LoadCurrentAds()),
        ),
      ],
      child: BlocBuilder<ProfileBloc, BaseState<UserModel>>(
        builder: (context, profileState) {
          final isProfileLoading = profileState is LoadingState;

          return LoadingOverlay(
            isLoading: isProfileLoading,
            child: BlocBuilder<ProfileAdsBloc, BaseState<List<AdModel>>>(
              builder: (context, adsState) {
                final isAdsLoading = adsState is LoadingState;

                return LoadingOverlay(
                  isLoading: isAdsLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // --- Profile Info ---
                        if (profileState is SuccessState<UserModel>) ...[
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "https://dummyimage.com/300",
                                ),
                                onBackgroundImageError: (_, __) {
                                },
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(profileState.data.name),
                                  Text(profileState.data.phone),
                                ],
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed:
                                  () => context.read<ProfileAdsBloc>().add(
                                    LoadPreviousAds(),
                                  ),
                              child: Text('previous'.tr()),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed:
                                  () => context.read<ProfileAdsBloc>().add(
                                    LoadCurrentAds(),
                                  ),
                              child: Text('current'.tr()),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // --- Ads List ---
                        if (adsState is SuccessState<List<AdModel>>) ...[
                          Expanded(
                            child: ListView.builder(
                              itemCount: adsState.data.length,
                              itemBuilder: (_, i) {
                                final ad = adsState.data[i];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      safeNetworkImage(ad.imageUrl, width: 100, height: 80),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(ad.title),
                                            Text(
                                              ad.statusText,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Text('view_ad'.tr()),
                                                ),
                                                if (!ad.isExpired)
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text('delete'.tr()),
                                                  )
                                                else
                                                  OutlinedButton(
                                                    onPressed: null,
                                                    child: Text('expired'.tr()),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
