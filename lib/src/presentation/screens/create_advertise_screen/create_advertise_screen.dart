import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailors/src/core/widgets/sailors_app_bar.dart';
import '../../../core/bloc/base_state.dart';
import '../../../data/models/params/create_advertise_params.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_toggle.dart';
import '../../../widgets/generic_selectable_wrap.dart';
import 'create_advertise_bloc.dart';
import 'create_advertise_event.dart';

class CreateAdvertiseScreen extends StatefulWidget {
  const CreateAdvertiseScreen({super.key});

  @override
  State<CreateAdvertiseScreen> createState() => _CreateAdvertiseScreenState();
}

class _CreateAdvertiseScreenState extends State<CreateAdvertiseScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedType = AdvertiseType.normal.value;
  String _selectedStatus = AdvertiseStatus.new_.value;

  String? _selectedPackageId;
  String? _selectedCategoryId;
  String _selectedPrice = '';
  String _selectedAdvertisementTypeId = '';

  int _selectedTypeIndex = 0;
  int _selectedStatusIndex = 0;
  int _selectedPackageIndex = -1;

  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final List<File> _images = [];

  @override
  void initState() {
    super.initState();
    context.read<CreateAdvertiseBloc>().add(FetchScreenData());
  }

  void _pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() => _images.addAll(picked.map((x) => File(x.path))));
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate() ||
        _selectedPackageId == null ||
        _selectedCategoryId == null) {
      return;
    }

    final params = CreateAdvertiseParams(
      name: _detailsController.text,
      details: _detailsController.text,
      categoryId: _selectedCategoryId!,
      packageId: _selectedPackageId!,
      advertisementTypeId: _selectedAdvertisementTypeId,
      type: _selectedType,
      status: _selectedStatus,
      phone: _phoneController.text,
      whatsapp: _phoneController.text,
      adPrice: _selectedPrice,
      coupon: '',
      images: _images,
    );

    context.read<CreateAdvertiseBloc>().add(SubmitAdvertise(params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SailorsAppBar(title: "create_ad".tr(), showBackButton: false),
      body: BlocConsumer<CreateAdvertiseBloc, BaseState<CreateAdvertiseState>>(
        listener: (context, state){
          if (state is FailureState<CreateAdvertiseState>) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is SuccessState<CreateAdvertiseState>) {
            if (state.data?.isSubmitted ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('success'.tr())));
              Navigator.pop(context, true);
            }
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          final packages =
              (state is SuccessState<CreateAdvertiseState>)
                  ? state.data?.packages
                  : [];
          final categories =
              (state is SuccessState<CreateAdvertiseState>)
                  ? state.data?.categories
                  : [];

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'ad_type'.tr()}*'),
                  const SizedBox(height: 8),
                  CustomToggle(
                    selectedIndex: _selectedTypeIndex,
                    labels: ['normal'.tr(), 'premium'.tr()],
                    onChanged: (index) {
                      setState(() {
                        _selectedTypeIndex = index;
                        _selectedType = AdvertiseType.values[index].value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('${'duration'.tr()}*'),
                  GenericSelectableWrap(
                    items: packages!,
                    selectedIndex: _selectedPackageIndex,
                    getLabelLeft: (pkg) => pkg.advertisementType.name,
                    getLabelRight: (pkg) => '${pkg.price} د.ك',
                    onSelected: (index) {
                      final pkg = packages[index];
                      setState(() {
                        _selectedPackageIndex = index;
                        _selectedPackageId = pkg.id.toString();
                        _selectedPrice = pkg.price;
                        _selectedAdvertisementTypeId = pkg.advertisementType.id.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('${'category'.tr()}*'),
                  const SizedBox(height: 8),
                  CustomDropdown(
                    items: categories!,
                    selectedValue: _selectedCategoryId,
                    getLabel: (cat) => cat.name,
                    getValue: (cat) => cat.id.toString(),
                    onChanged: (val) => setState(() => _selectedCategoryId = val),
                    labelText: 'category'.tr(),
                  ),
                  const SizedBox(height: 16),
                  Text('${'status'.tr()}*'),
                  const SizedBox(height: 8),
                  CustomToggle(
                    selectedIndex: _selectedStatusIndex,
                    labels: ['new'.tr(), 'used'.tr()],
                    onChanged: (index) {
                      setState(() {
                        _selectedStatusIndex = index;
                        _selectedStatus = AdvertiseStatus.values[index].value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('${'description'.tr()}*'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _detailsController,
                    decoration: InputDecoration(labelText: 'description'.tr()),
                    maxLines: 3,
                    validator: (v) => v!.isEmpty ? 'required'.tr() : null,
                  ),

                  const SizedBox(height: 16),
                  Text('${'upload_images'.tr()}*'),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Icon(Icons.cloud_upload)),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text('${'price'.tr()}*'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: TextEditingController(text: _selectedPrice),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'price'.tr()),
                    validator: (v) => v!.isEmpty ? 'required'.tr() : null,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  Text('${'phone'.tr()}*'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'phone_number'.tr()),
                    validator: (v) => v!.isEmpty ? 'required'.tr() : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text('next'.tr()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
