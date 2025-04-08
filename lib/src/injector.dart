import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sailors/src/presentation/blocs/remote_items/remote_items_bloc.dart';
import 'data/datasources/remote/items_api_service.dart';
import 'data/repositories/items_repository_impl.dart';
import 'domain/repositories/items_repository.dart';
import 'domain/usecaes/get_items_usecase.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<ItemsApiService>(ItemsApiService(injector()));
  injector.registerSingleton<ItemsRepository>(ItemsRepositoryImpl(injector()));

  // UseCases
  injector.registerSingleton<GetItemsUseCase>(GetItemsUseCase(injector()));

  // Blocs
  injector.registerFactory<RemoteItemsBloc>(() => RemoteItemsBloc(injector()));
}
