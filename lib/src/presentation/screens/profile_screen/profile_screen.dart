import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_ads_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../config/routes/app_routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/fonts/app_text_styles.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/widgets/ad_widget.dart';
import '../../../core/widgets/sailors_app_bar.dart';
import '../../../data/models/ad_model.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/loading_overlay.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<ProfileBloc>()..add(LoadProfile())),
        BlocProvider(
          create: (_) => GetIt.I<ProfileAdsBloc>()..add(LoadCurrentAds()),
        ),
      ],
      child: Scaffold(
        appBar: SailorsAppBar(
          showBackButton: false,
          title: 'personal_profile',
          trailing: [
            IconButton(
              icon: SvgPicture.asset(
                'images/settings_icon.svg',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RoutesConstants.settingsScreen);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, BaseState<UserModel>>(
            builder: (context, profileState) {
              return BlocBuilder<ProfileAdsBloc, BaseState<List<AdModel>>>(
                builder: (context, adsState) {
                  final isAdsLoading = adsState is LoadingState;
                  final isPrevious =
                      adsState is SuccessState<List<AdModel>> &&
                      adsState.data?.firstOrNull?.isExpired == true;

                  return LoadingOverlay(
                    isLoading: isAdsLoading,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          if (profileState is SuccessState<UserModel>) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      "https://dummyimage.com/300",
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('name'.tr()),
                                    Text(
                                      profileState.data?.name ?? "",
                                      style: AppTextStyles.bold,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('phone_number'.tr()),
                                    Text(
                                      profileState.data?.phone ?? "",
                                      style: AppTextStyles.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "ads".tr(),
                              textAlign: TextAlign.start,
                              style: AppTextStyles.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.color_F5F5F5,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap:
                                        () => context
                                            .read<ProfileAdsBloc>()
                                            .add(LoadPreviousAds()),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            isPrevious
                                                ? AppColors.color_51AACC
                                                : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        'previous'.tr(),
                                        style: AppTextStyles.bold.copyWith(
                                          color:
                                              isPrevious
                                                  ? AppColors.color_FFFFFF
                                                  : AppColors.color_CCCCCC,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap:
                                        () => context
                                            .read<ProfileAdsBloc>()
                                            .add(LoadCurrentAds()),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            !isPrevious
                                                ? AppColors.color_51AACC
                                                : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        'current'.tr(),
                                        style: AppTextStyles.bold.copyWith(
                                          color:
                                              !isPrevious
                                                  ? AppColors.color_FFFFFF
                                                  : AppColors.color_CCCCCC,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (adsState is SuccessState<List<AdModel>>) ...[
                            Expanded(
                              child: ListView.builder(
                                itemCount: adsState.data?.length,
                                itemBuilder: (_, i) {
                                  return AdCard(ad: adsState.data?[i]);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
