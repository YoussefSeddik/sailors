import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../data/models/ad_model.dart';
import '../../../domain/usecaes/app_usecase.dart';
class ProfileAdsBloc
    extends BlocWithState<ProfileEvent, BaseState<List<AdModel>>> {
  final AppUseCases appUseCases;

  ProfileAdsBloc(this.appUseCases)
    : super(InitialState()) {
    on<LoadCurrentAds>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          yield LoadingState();
          final ads = await appUseCases.getCurrentAds();
          yield SuccessState(ads.data);
        }),
        onData: (s) => s,
      );
    });

    on<LoadPreviousAds>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          yield LoadingState();
          final ads = await appUseCases.getPreviousAds();
          yield SuccessState(ads.data);
        }),
        onData: (s) => s,
      );
    });
  }
}
