import 'package:sailors/src/core/bloc/base_state.dart';

import '../../../data/models/ad_model.dart';

abstract class ProfileState extends BaseState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String phone;
  final String imageUrl;
  final List<AdModel> ads;
  final bool isCurrent;

  ProfileLoaded({
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.ads,
    required this.isCurrent,
  });
}