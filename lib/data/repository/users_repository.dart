
import 'package:amca/data/api/users_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';

abstract class UsersRepository {
  Future<List<AmcaUser>> getAllUsers();
}

class UsersRepositoryAdapter extends UsersRepository {
  final UsersApi _api = locator<UsersApi>();

  @override
  Future<List<AmcaUser>> getAllUsers() {
    return _api.getAllUsers();
  }
}
