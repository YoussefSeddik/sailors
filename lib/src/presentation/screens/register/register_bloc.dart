import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/presentation/screens/register/register_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/params/register_params.dart';
import '../../../domain/usecaes/app_usecase.dart';

class RegisterBloc extends BlocWithState<RegisterEvent, BaseState<void>> {
  final AppUseCases appUseCases;

  RegisterBloc(this.appUseCases) : super(InitialState()) {
    on<RegisterSubmitted>((event, stateEmitter) async {
      await stateEmitter.forEach(
        runBlocProcess(() async* {
          stateEmitter(LoadingState());
          final result = await appUseCases.register(
            RegisterParams(
              name: event.name,
              phone: event.phone,
              password: event.password,
            ),
          );
          if (result is DataSuccess) {
            yield SuccessState<AuthModel?>(result.data);
          } else {
            yield FailureState(result.error?.message ?? 'Unknown error');
          }
        }),
        onData: (s) => s,
      );
    });
  }
}
