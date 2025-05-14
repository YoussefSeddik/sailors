import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/params/login_params.dart';
import '../../../domain/usecaes/app_usecase.dart';
import 'login_event.dart';

class LoginBloc extends BlocWithState<LoginEvent, BaseState<void>> {
  final AppUseCases appUseCases;

  LoginBloc(this.appUseCases) : super(InitialState()) {
    on<LoginSubmitted>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          emit(LoadingState());
          final result = await appUseCases.login(
            LoginParams(phone: event.phone, password: event.password),
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
