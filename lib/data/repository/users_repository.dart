/// {@category Repository}
/// This file contains the implementation of an interface `UsersRepository` and its adapter `UsersRepositoryAdapter`
/// 
/// which provide methods to interact with user data.
library;

/// Imports of Bookstores and Resources
import 'package:amca/data/api/users_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';

/// Abstract class defining methods for accessing user data.
abstract class UsersRepository {
  Future<List<AmcaUser>> getAllUsers();/// Retrieves a list of all users.
  Future<AmcaUser> manageAdminUser(AmcaUser user);  /// Manages an admin user.
}

/// Implementation of the `UsersRepository` interface.
class UsersRepositoryAdapter extends UsersRepository {
  final UsersApi _api = locator<UsersApi>(); /// Instance of `UsersApi` for interacting with user-related APIs.

  @override
  Future<List<AmcaUser>> getAllUsers() {
    return _api.getAllUsers();
  }

  @override
  Future<AmcaUser> manageAdminUser(AmcaUser user) {
    return _api.manageAdminUser(user);
  }
}
