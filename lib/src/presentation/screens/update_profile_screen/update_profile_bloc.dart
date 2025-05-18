import 'package:sailors/src/core/bloc/base_state.dart';
import 'package:sailors/src/core/bloc/bloc_with_state.dart';
import 'package:sailors/src/core/resources/data_state.dart';
import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/user_model.dart';
import 'package:sailors/src/domain/usecaes/app_usecase.dart';
import 'package:sailors/src/presentation/screens/update_profile_screen/update_profile_event.dart';

import '../../../core/caching/local_storage_service.dart';

class UpdateProfileScreenBloc
    extends BlocWithState<UpdateProfileEvent, BaseState<UpdateProfileState>> {
  final AppUseCases appUseCases;
  final LocalStorageService _storageService;

  UpdateProfileScreenBloc(this.appUseCases, this._storageService)
    : super(InitialState()) {
    on<LoadProfileData>((event, stateEmitter) async {
      final auth = await _storageService.getModelAsync(
        AuthModel.storageKey,
        AuthModel.fromJson,
      );
      if (auth != null) {
        stateEmitter(SuccessState(UpdateProfileState(auth.user)));
      }
    });

    on<UpdateProfileData>((event, stateEmitter) async {
      stateEmitter(LoadingState());
      final result = await appUseCases.updateProfile(event.params);
      if (result is DataSuccess) {
        stateEmitter(
          SuccessState(
            UpdateProfileState(result.data, isFromUpdate: true),
          ),
        );
      } else {
        stateEmitter(FailureState(result.message ?? 'Unknown error'));
      }
    });
  }
}

class UpdateProfileState extends BaseState<UserModel> {
  final UserModel? user;
  final bool isFromUpdate;

  UpdateProfileState(this.user, {this.isFromUpdate = false});
}
