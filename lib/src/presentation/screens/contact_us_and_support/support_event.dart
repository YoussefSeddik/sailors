import '../../../data/models/params/send_contact_us_params.dart';
import '../../../data/models/params/support_params.dart';

abstract class SupportEvent {}

class SendSupportEvent extends SupportEvent {
  final SupportRequestParams params;

  SendSupportEvent(this.params);
}

class SendContactUsEvent extends SupportEvent {
  final ContactUsParams params;

  SendContactUsEvent(this.params);
}