import 'package:sailors/src/data/models/auth_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sailors/src/presentation/screens/welcome_screen/welcome_states.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/caching/local_storage_service.dart';
import 'welcome_event.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/presentation/screens/welcome_screen/welcome_states.dart';
import '../../../core/caching/local_storage_service.dart';
import 'welcome_event.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final LocalStorageService _storageService = GetIt.I<LocalStorageService>();

  WelcomeBloc() : super(WelcomeInitial()) {
    on<CheckAuthEvent>(_onCheckAuth);
  }

  Future<void> _onCheckAuth(
      CheckAuthEvent event,
      Emitter<WelcomeState> emit,
      ) async {
    try {
      final auth = await _storageService.getModelAsync<AuthModel>(
        AuthModel.storageKey,
        AuthModel.fromJson,
      );

      if (auth != null) {
        emit(NavigateToMain());
      } else {
        emit(NavigateToLogin());
      }
    } catch (e) {
      emit(WelcomeInitial()); // fallback to initial state or handle error as needed
    }
  }
}

