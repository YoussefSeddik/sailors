import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/widgets/sailors_app_bar.dart';
import '../../../data/models/advertise_model.dart';

class AdvertiseInvoiceScreen extends StatelessWidget {
  final AdvertiseModel model;

  const AdvertiseInvoiceScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: SailorsAppBar(title: 'advertise_invoice'.tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Image.asset(
                'images/advertise_created_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            _infoRow(context, 'advertiser_name'.tr(), model.user?.name),
            _infoRow(context, 'phone_number'.tr(), model.user?.phone),
            _infoRow(context, 'ad_type'.tr(), _mapType(model.type)),
            _infoRow(context, 'ad_duration'.tr(), model.package?.advertisementType?.name ?? '-',),
            _infoRow(context, 'category'.tr(), model.category?.name),
            _infoRow(context, 'status'.tr(), _mapStatus(model.status)),
            _infoRow(context, 'description'.tr(), model.details),
            _imagesRow(context, model.images ?? []),
            _infoRow(context, 'contact_number'.tr(), model.phone),
            const SizedBox(height: 16),
            _totalRow(context, model.adPrice ?? '0'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text('download'.tr()),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text('home'.tr()),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _mapType(String? type) {
    return type == 'normal' ? 'normal'.tr() : 'premium'.tr();
  }

  String _mapStatus(String? status) {
    return status == 'new' ? 'new'.tr() : 'used'.tr();
  }

  Widget _infoRow(BuildContext context, String title, String? value) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final labelColor = Theme.of(context).colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(title, style: TextStyle(color: labelColor))),
          const SizedBox(width: 12),
          Text(value ?? '', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _imagesRow(BuildContext context, List<AdvertisementImage> images) {
    if (images.isEmpty) return const SizedBox.shrink();

    final labelColor = Theme.of(context).colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('images'.tr(), style: TextStyle(color: labelColor)),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                separatorBuilder:
                    (_, index) =>
                        SizedBox(width: index == images.length - 1 ? 0 : 8),
                itemBuilder: (_, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      images[index].image ?? '',
                      width: 50,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => const Icon(Icons.broken_image),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalRow(BuildContext context, String price) {
    final textColor = Theme.of(context).colorScheme.primary;
    final labelColor = Theme.of(context).colorScheme.onBackground;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('total'.tr(), style: TextStyle(color: labelColor)),
          const Spacer(),
          Text('د.ك $price', style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
