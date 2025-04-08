import 'package:sailors/src/core/params/items_request.dart';

import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../entities/item.dart';
import '../repositories/items_repository.dart';

class GetItemsUseCase implements UseCase<DataState<List<Item>>, ItemsRequestParams> {
  final ItemsRepository _itemsRepository;

  GetItemsUseCase(this._itemsRepository);

  @override
  Future<DataState<List<Item>>> call({required ItemsRequestParams params}) {
    return _itemsRepository.getItems(params);
  }
}
