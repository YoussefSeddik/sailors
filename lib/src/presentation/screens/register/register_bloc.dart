import 'package:sailors/src/domain/usecaes/register_usecase.dart';
import 'package:sailors/src/presentation/screens/register/register_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/params/register_params.dart';

class RegisterBloc extends BlocWithState<LoginEvent, BaseState<void>> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(InitialState()) {
    on<RegisterSubmitted>(
      (event, emit) => runBlocProcess(() async* {
        emit(LoadingState());

        final result = await registerUseCase(
          params: RegisterParams(name: event.name, phone: event.phone, password: event.password),
        );

        if (result is DataSuccess) {
          yield SuccessState(null);
        } else {
          yield FailureState(result.error?.message ?? 'Unknown error');
        }
      }),
    );
  }
}
