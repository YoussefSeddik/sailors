import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/data/models/advertise_model.dart';
import 'package:sailors/src/injector.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isPreviousSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectCurrentAds();
    });
  }

  void _selectPreviousAds() {
    setState(() => isPreviousSelected = true);
    context.read<ProfileAdsBloc>().add(LoadPreviousAds());
  }

  void _selectCurrentAds() {
    setState(() => isPreviousSelected = false);
    context.read<ProfileAdsBloc>().add(LoadCurrentAds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SailorsAppBar(
        showBackButton: false,
        title: 'personal_profile'.tr(),
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
            return BlocBuilder<ProfileAdsBloc, BaseState<List<AdvertiseModel>>>(
              builder: (context, adsState) {
                final isAdsLoading = adsState is LoadingState;
                final ads = adsState is SuccessState<List<AdvertiseModel>>
                    ? adsState.data ?? []
                    : [];

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
                        _buildTabs(),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ads.isNotEmpty
                              ? ListView.builder(
                            itemCount: ads.length,
                            itemBuilder: (_, i) => AdCard(ad: ads[i]),
                          )
                              : Center(
                            child: Text(
                              'no_ads_found'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.color_F5F5F5,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _tabButton(
            label: 'previous'.tr(),
            selected: isPreviousSelected,
            onTap: _selectPreviousAds,
          ),
          _tabButton(
            label: 'current'.tr(),
            selected: !isPreviousSelected,
            onTap: _selectCurrentAds,
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? AppColors.color_51AACC : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            label,
            style: AppTextStyles.bold.copyWith(
              color: selected ? AppColors.color_FFFFFF : AppColors.color_CCCCCC,
            ),
          ),
        ),
      ),
    );
  }
}

