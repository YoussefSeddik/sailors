import 'package:sailors/src/data/models/params/update_profile_params.dart';

abstract class UpdateProfileEvent {}

class LoadProfileData extends UpdateProfileEvent {}

class UpdateProfileData extends UpdateProfileEvent {
  final UpdateProfileParams params;

  UpdateProfileData(this.params);
}
