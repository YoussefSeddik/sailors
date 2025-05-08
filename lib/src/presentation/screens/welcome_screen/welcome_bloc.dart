import 'package:sailors/src/data/models/auth_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sailors/src/presentation/screens/welcome_screen/welcome_states.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/caching/local_storage_service.dart';
import 'welcome_event.dart';

class WelcomeBloc extends BlocWithState<WelcomeEvent, WelcomeState> {
  final LocalStorageService _storageService = GetIt.I<LocalStorageService>();

  WelcomeBloc() : super(WelcomeInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          final auth = await _storageService.getModelAsync(
            AuthModel.storageKey,
            AuthModel.fromJson,
          );
          if (auth != null) {
            yield NavigateToMain();
          } else {
            yield NavigateToLogin();
          }
        }),
        onData: (state) => state,
      );
    });
  }
}
