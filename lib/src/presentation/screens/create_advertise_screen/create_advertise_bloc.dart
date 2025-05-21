import 'package:sailors/src/core/bloc/base_state.dart';
import 'package:sailors/src/core/bloc/bloc_with_state.dart';
import 'package:sailors/src/core/resources/data_state.dart';
import 'package:sailors/src/domain/usecaes/app_usecase.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/package_model.dart';
import 'create_advertise_event.dart';

class CreateAdvertiseBloc
    extends
        BlocWithState<CreateAdvertiseEvent, BaseState<CreateAdvertiseState>> {
  final AppUseCases _appUseCases;



  CreateAdvertiseBloc(this._appUseCases) : super(InitialState()) {
    on<FetchScreenData>((event, emit) async {
      emit(LoadingState());
      try {
        final results = await Future.wait([
          _appUseCases.getAllPackages(),
          _appUseCases.getAllCategories(),
        ]);

        final packagesResult = results[0];
        final categoriesResult = results[1];

        if (packagesResult is DataSuccess && categoriesResult is DataSuccess) {
          emit(SuccessState(CreateAdvertiseState(
              packages: packagesResult.data as List<PackageModel>,
              categories: categoriesResult.data as List<CategoryModel>
          )));
        } else {
          emit(FailureState("Failed to load data"));
        }
      } catch (e) {
        emit(FailureState("Unexpected error: ${e.toString()}"));
      }
    });

    on<SubmitAdvertise>((event, emit) async {
      emit(LoadingState());
      final result = await _appUseCases.createAdvertisement(event.params);
      if (result is DataSuccess) {
        emit(SuccessState(CreateAdvertiseState(isSubmitted: true)));
      } else {
        emit(FailureState(result.message ?? 'Unknown error'));
      }
    });
  }
}

class CreateAdvertiseState extends BaseState {
  final List<PackageModel> packages;
  final List<CategoryModel> categories;
  final bool isSubmitted;

  CreateAdvertiseState({
    this.packages = const [],
    this.categories = const [],
    this.isSubmitted = false,
  });
}
