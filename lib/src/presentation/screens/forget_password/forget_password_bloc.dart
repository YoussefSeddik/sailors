import 'package:sailors/src/data/models/user_model.dart';
import 'package:sailors/src/domain/usecaes/app_usecase.dart';
import 'package:sailors/src/presentation/screens/forget_password/forget_password_event.dart';

import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';

class ForgetPasswordBloc
    extends BlocWithState<ForgetPassword, BaseState<UserModel>> {
  final AppUseCases appUseCases;

  ForgetPasswordBloc(this.appUseCases) : super(InitialState()) {
    on<ForgetPassword>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          emit(LoadingState());
          final result = await appUseCases.sendOtp(event.phone);
          if (result is DataSuccess) {
            yield SuccessState(result.data);
          } else {
            yield FailureState(result.message ?? 'Unknown error');
          }
        }),
        onData: (s) => s,
      );
    });
  }
}
