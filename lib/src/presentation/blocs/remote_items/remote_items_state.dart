
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/item.dart';

abstract class RemoteItemsState extends Equatable {
  final List<Item>? items;
  final bool? noMoreData;

  final DioError? error;

  const RemoteItemsState({this.items, this.noMoreData, this.error});

  @override
  List<Object?> get props => [items, noMoreData, error];
}

class RemoteItemsLoading extends RemoteItemsState {
  const RemoteItemsLoading();
}
class RemoteItemsInitial extends RemoteItemsState {
  const RemoteItemsInitial();
}


class RemoteItemsDone extends RemoteItemsState {
  const RemoteItemsDone(List<Item> items)
      : super(items: items);
}

class RemoteItemsError extends RemoteItemsState {
  const RemoteItemsError(DioError? error) : super(error: error);
}
