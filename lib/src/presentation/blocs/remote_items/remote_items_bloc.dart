import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sailors/src/core/params/items_request.dart';
import 'package:sailors/src/presentation/blocs/remote_items/remote_items_event.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/usecaes/get_items_usecase.dart';
import 'remote_items_state.dart';

class RemoteItemsBloc
    extends BlocWithState<RemoteItemsEvent, RemoteItemsState> {
  final GetItemsUseCase _getArticlesUseCase;

  final List<Item> _items = [];

  RemoteItemsBloc(this._getArticlesUseCase)
      : super(const RemoteItemsInitial()) {
    on<GetItems>((event, emit) async {
      emit(const RemoteItemsLoading());
      final dataState =
      await _getArticlesUseCase(params: const ItemsRequestParams());
      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        final items = dataState.data;
        _items.addAll(items!);
        emit( RemoteItemsDone(_items));
      }
      if (dataState is DataFailed) {
        emit(RemoteItemsError(dataState.error));
      }
    });
  }
}
