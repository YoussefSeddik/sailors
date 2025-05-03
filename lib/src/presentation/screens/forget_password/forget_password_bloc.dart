import 'package:sailors/src/presentation/screens/forget_password/forget_password_event.dart';

import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/usecaes/send_otp_usecase.dart';



class ForgetPasswordBloc
    extends BlocWithState<ForgetPassword, BaseState<void>> {
  final SendOtpUseCase sendOtpUseCase;

  ForgetPasswordBloc(this.sendOtpUseCase) : super(InitialState()) {
    on<ForgetPassword>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          emit(LoadingState());
          final result = await sendOtpUseCase(
            params: event.phone,
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
