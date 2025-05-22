import 'package:get_it/get_it.dart';
import 'package:sailors/src/data/models/user_model.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/caching/local_storage_service.dart';
import '../../../data/models/auth_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, BaseState<UserModel>> {
  final LocalStorageService storage = GetIt.I();

  ProfileBloc() : super(InitialState()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
      LoadProfile event,
      Emitter<BaseState<UserModel>> emit,
      ) async {
    emit(LoadingState());

    try {
      final authModel = await storage.getModelAsync<AuthModel>(
        AuthModel.storageKey,
        AuthModel.fromJson,
      );
      final user = authModel?.user;

      if (user == null) {
        emit(FailureState('User not found'));
      } else {
        emit(SuccessState(user));
      }
    } catch (e) {
      emit(FailureState('Unexpected error: ${e.toString()}'));
    }
  }
}
