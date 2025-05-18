import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailors/src/core/widgets/sailors_app_bar.dart';
import 'package:sailors/src/data/models/params/update_profile_params.dart';
import 'package:sailors/src/injector.dart';
import 'package:sailors/src/presentation/screens/update_profile_screen/update_profile_bloc.dart';
import 'package:sailors/src/presentation/screens/update_profile_screen/update_profile_event.dart';
import 'package:sailors/src/widgets/loading_overlay.dart';

import '../../../core/bloc/base_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  File? selectedImage;
  String? userAvatar;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        selectedImage = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<UpdateProfileScreenBloc>()..add(LoadProfileData()),
      child: Scaffold(
        appBar: SailorsAppBar(title: "edit_profile".tr()),
        body: SafeArea(
          child: BlocConsumer<UpdateProfileScreenBloc, BaseState<UpdateProfileState>>(
            listener: (context, state) {
              if (state is SuccessState<UpdateProfileState> && state.data?.isFromUpdate == true) {
                Navigator.pop(context);
              } else if (state is FailureState<UpdateProfileState>) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is LoadingState;

              if (state is SuccessState<UpdateProfileState> && nameController.text.isEmpty) {
                nameController.text = state.data?.user?.name ?? '';
                phoneController.text = state.data?.user?.phone ?? '';
                userAvatar = state.data?.user?.avatar;
              }

              return LoadingOverlay(
                isLoading: isLoading,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: selectedImage != null
                                  ? FileImage(selectedImage!)
                                  : (userAvatar != null
                                  ? NetworkImage(userAvatar!)
                                  : null) as ImageProvider?,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'change_photo'.tr(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('name'.tr()),
                      const SizedBox(height: 8),
                      TextField(controller: nameController),
                      const SizedBox(height: 14),
                      Text('phone_number'.tr()),
                      const SizedBox(height: 8),
                      TextField(controller: phoneController),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<UpdateProfileScreenBloc>().add(
                                  UpdateProfileData(
                                    UpdateProfileParams(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      avatar: selectedImage,
                                    ),
                                  ),
                                );
                              },
                              child: Text('save_changes'.tr()),
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
      ),
    );
  }
}
