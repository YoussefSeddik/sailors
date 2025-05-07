import 'package:sailors/src/data/models/params/update_password_params.dart';
import 'package:sailors/src/domain/usecaes/update_password_usecase.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_event.dart';

import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';

class UpdatePasswordBloc
    extends BlocWithState<UpdatePasswordEvent, BaseState<void>> {
  final UpdatePasswordUseCase useCase;

  UpdatePasswordBloc(this.useCase) : super(InitialState()) {
    on<SubmitPassword>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          emit(LoadingState());
          final result = await useCase(
            params: UpdatePasswordParams(
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
