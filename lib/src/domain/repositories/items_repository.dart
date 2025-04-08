import '../../core/params/items_request.dart';
import '../../core/resources/data_state.dart';
import '../entities/item.dart';

abstract class ItemsRepository {
  Future<DataState<List<Item>>> getItems(ItemsRequestParams params);
}
