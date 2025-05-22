import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/data/models/advertise_model.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_ads_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/fonts/app_text_styles.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/widgets/ad_widget.dart';
import '../../../core/widgets/sailors_app_bar.dart';
import '../../../widgets/loading_overlay.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
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
      appBar: SailorsAppBar(showBackButton: false, title: 'my_ads'.tr()),
      body: SafeArea(
        child: BlocBuilder<ProfileAdsBloc, BaseState<List<AdvertiseModel>>>(
          builder: (context, state) {
            final isLoading = state is LoadingState;
            final ads = state is SuccessState<List<AdvertiseModel>> ? state.data ?? [] : [];

            return LoadingOverlay(
              isLoading: isLoading,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
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
            selected: isPreviousSelected,
            label: 'previous'.tr(),
            onTap: _selectPreviousAds,
          ),
          _tabButton(
            selected: !isPreviousSelected,
            label: 'current'.tr(),
            onTap: _selectCurrentAds,
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required bool selected,
    required String label,
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

