import 'package:sailors/src/data/models/params/update_password_params.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_event.dart';

import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/usecaes/app_usecase.dart';

class UpdatePasswordBloc
    extends BlocWithState<UpdatePasswordEvent, BaseState<void>> {
  final AppUseCases appUseCases;

  UpdatePasswordBloc(this.appUseCases) : super(InitialState()) {
    on<SubmitPassword>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          emit(LoadingState());
          final result = await appUseCases.updatePassword(
            UpdatePasswordParams(
              password: event.password,
              confirmedPassword: event.confirmedPassword,
            ),
          );
          if (result is DataSuccess) {
            yield SuccessState(null);
          } else {
            yield FailureState(result.error?.message ?? 'Unknown error');
          }
        }),
        onData: (s) => s,
      );
    });
  }
}
