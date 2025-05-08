import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../data/models/ad_model.dart';
import '../../../domain/usecaes/get_current_ads_usecase.dart';
import '../../../domain/usecaes/get_previous_ads_usecase.dart';

class ProfileAdsBloc
    extends BlocWithState<ProfileEvent, BaseState<List<AdModel>>> {
  final GetCurrentAdsUseCase getCurrentAds;
  final GetPreviousAdsUseCase getPreviousAds;

  ProfileAdsBloc(this.getCurrentAds, this.getPreviousAds)
    : super(InitialState()) {
    on<LoadCurrentAds>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          yield LoadingState();
          final ads = await getCurrentAds();
          yield SuccessState(ads);
        }),
        onData: (s) => s,
      );
    });

    on<LoadPreviousAds>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          yield LoadingState();
          final ads = await getPreviousAds();
          yield SuccessState(ads);
        }),
        onData: (s) => s,
      );
    });
  }
}
