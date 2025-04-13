import 'package:sailors/src/data/models/params/register_params.dart';
import 'package:sailors/src/data/models/user_model.dart';

import '../../core/resources/data_state.dart';
import '../../data/models/params/login_params.dart';

abstract class AuthRepository {
  Future<DataState<UserModel>> login(LoginParams params);

  Future<DataState<UserModel>> register(RegisterParams params);
}
