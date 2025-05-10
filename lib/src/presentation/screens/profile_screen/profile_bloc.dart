import 'package:get_it/get_it.dart';
import 'package:sailors/src/data/models/user_model.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/caching/local_storage_service.dart';
import '../../../data/models/auth_model.dart';

class ProfileBloc extends BlocWithState<ProfileEvent, BaseState<UserModel>> {
  final LocalStorageService storage = GetIt.I();

  ProfileBloc() : super(InitialState()) {
    on<LoadProfile>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          final authModel = await storage.getModelAsync<AuthModel>(
            AuthModel.storageKey,
            AuthModel.fromJson,
          );
          final user = authModel?.user;
          if (user == null) {
            yield FailureState('User not found');
            return;
          }
          yield SuccessState(user);
        }),
        onData: (s) => s,
      );
    });
  }
}
