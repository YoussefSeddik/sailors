import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/config/localization/app_language.dart';
import 'package:sailors/src/config/themes/app_colors.dart';
import 'package:sailors/src/config/themes/fonts/app_text_styles.dart';
import 'package:sailors/src/core/widgets/safe_network_image.dart';

import '../../data/models/ad_model.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sailors/src/config/localization/app_language.dart';
import 'package:sailors/src/config/themes/app_colors.dart';
import 'package:sailors/src/config/themes/fonts/app_text_styles.dart';
import 'package:sailors/src/core/widgets/safe_network_image.dart';
import 'package:sailors/src/data/models/advertise_model.dart';

class AdCard extends StatelessWidget {
  final AdvertiseModel? ad;

  const AdCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpired = ad?.isExpired ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: safeNetworkImage(
                ad?.images?.firstOrNull?.image ?? "",
                width: 120,
                height: 90,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ad?.name ?? "",
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (!isExpired) ...[
                    RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(text: '${'ad_expires_in'.tr()} '),
                          TextSpan(
                            text:
                                '${ad?.daysUntilExpiration ?? 0} ${'days'.tr()}',
                            style: const TextStyle(
                              color: AppColors.color_00A9C8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(
                              color: AppColors.color_grey_light,
                            ),
                          ),
                          child: Text(
                            isExpired ? 'expired'.tr() : 'view_ad'.tr(),
                            style: AppTextStyles.regular.copyWith(
                              color: AppColors.color_grey_dark,
                            ),
                          ),
                        ),
                      ),
                      if (!isExpired)
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: AppLanguage().isArabic ? 0.0 : 8.0,
                            end: AppLanguage().isArabic ? 8.0 : 0.0,
                          ),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.color_00A9C8,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'delete'.tr(),
                              style: const TextStyle(
                                color: AppColors.color_FFFFFF,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
