import 'package:sailors/src/data/models/advertise_model.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/usecaes/app_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAdsBloc
    extends Bloc<ProfileEvent, BaseState<List<AdvertiseModel>>> {
  final AppUseCases appUseCases;

  ProfileAdsBloc(this.appUseCases) : super(InitialState()) {
    on<LoadCurrentAds>((event, emit) async {
      emit(LoadingState());
      try {
        final result = await appUseCases.getCurrentAds();
        if (result is DataSuccess<List<AdvertiseModel>>) {
          emit(SuccessState(result.data));
        } else {
          emit(FailureState(result.message ?? 'Unknown error'));
        }
      } catch (e) {
        emit(FailureState('Failed to load current ads: ${e.toString()}'));
      }
    });
    on<LoadPreviousAds>((event, emit) async {
      emit(LoadingState());
      try {
        final result = await appUseCases.getPreviousAds();
        if (result is DataSuccess<List<AdvertiseModel>>) {
          emit(SuccessState(result.data));
        } else {
          emit(FailureState(result.message ?? 'Unknown error'));
        }
      } catch (e) {
        emit(FailureState('Failed to load current ads: ${e.toString()}'));
      }
    });
  }
}
