import 'package:equatable/equatable.dart';

abstract class RemoteItemsEvent extends Equatable {
  const RemoteItemsEvent();

  @override
  List<Object> get props => [];
}

class GetItems extends RemoteItemsEvent {
  const GetItems();
}
