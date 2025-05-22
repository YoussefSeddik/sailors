import 'package:sailors/src/core/bloc/base_state.dart';
import 'package:sailors/src/core/bloc/bloc_with_state.dart';
import 'package:sailors/src/core/resources/data_state.dart';
import 'package:sailors/src/data/models/notification_model.dart';
import 'package:sailors/src/domain/usecaes/app_usecase.dart';

class NotificationBloc
    extends
        BlocWithState<NotificationEvent, BaseState<List<NotificationModel>>> {
  final AppUseCases _appUseCases;

  NotificationBloc(this._appUseCases) : super(InitialState()) {
    on<FetchNotifications>((event, emit) async {
      emit(LoadingState());
      try {
        final result = await _appUseCases.getNotifications();
        if (result is DataSuccess<List<NotificationModel>>) {
          emit(SuccessState(result.data ?? []));
        } else {
          emit(FailureState(result.message ?? 'Unknown error'));
        }
      } catch (e) {
        emit(FailureState("Unexpected error: ${e.toString()}"));
      }
    });
  }
}

abstract class NotificationEvent {}

class FetchNotifications extends NotificationEvent {}
