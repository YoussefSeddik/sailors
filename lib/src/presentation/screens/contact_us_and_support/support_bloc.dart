import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/usecaes/app_usecase.dart';
import 'support_event.dart';

class SupportBloc extends Bloc<SupportEvent, BaseState<void>> {
  final AppUseCases appUseCases;

  SupportBloc(this.appUseCases) : super(InitialState()) {
    on<SendSupportEvent>(_onSendSupport);
    on<SendContactUsEvent>(_onSendContactUs);
  }

  Future<void> _onSendSupport(
    SendSupportEvent event,
    Emitter<BaseState<void>> emit,
  ) async {
    emit(LoadingState());
    final result = await appUseCases.sendSupport(event.params);
    if (result is DataSuccess) {
      emit(SuccessState(null));
    } else {
      emit(FailureState(result.message ?? 'Failed to send support request'));
    }
  }

  Future<void> _onSendContactUs(
    SendContactUsEvent event,
    Emitter<BaseState<void>> emit,
  ) async {
    emit(LoadingState());
    final result = await appUseCases.contactUs(event.params);
    if (result is DataSuccess) {
      emit(SuccessState(null));
    } else {
      emit(FailureState(result.message ?? 'Failed to contact us'));
    }
  }
}
