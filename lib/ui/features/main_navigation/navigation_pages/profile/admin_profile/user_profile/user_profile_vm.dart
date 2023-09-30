import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/data/repository/users_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:flutter/cupertino.dart';

class UserProfileVM extends ChangeNotifier {
  final UsersRepository usersRepository = locator<UsersRepository>();
  final LoginRepository loginRepository = locator<LoginRepository>();
  AmcaUser? userSelected;
  bool isLoading = false;

  Future<void> init(AmcaUser userSelected) async {
    try {
      this.userSelected = userSelected;
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  Future<AmcaUser?> manageAdminUser(AmcaUser user) async {
    isLoading = true;
    try {
      final userToAdmin = user.copyWith(
        isAdmin: !(user.isAdmin ?? false),
      );
      return await usersRepository.manageAdminUser(userToAdmin);
    } catch (e) {
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
