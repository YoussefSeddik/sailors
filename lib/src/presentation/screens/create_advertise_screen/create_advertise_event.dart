import '../../../data/models/params/create_advertise_params.dart';

abstract class CreateAdvertiseEvent {}

class FetchScreenData extends CreateAdvertiseEvent {}
class SubmitAdvertise extends CreateAdvertiseEvent {
  final CreateAdvertiseParams params;

  SubmitAdvertise(this.params);
}
