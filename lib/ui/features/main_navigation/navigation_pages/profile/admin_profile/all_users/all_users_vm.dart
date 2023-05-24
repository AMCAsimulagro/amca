import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/data/repository/users_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:flutter/cupertino.dart';

class AllUsersVM extends ChangeNotifier {
  final UsersRepository usersRepository = locator<UsersRepository>();
  final LoginRepository loginRepository = locator<LoginRepository>();
  List<AmcaUser> amcaUsers = [];

  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    try {
      final currentUser = await loginRepository.getUserCurrentlyLogged();
      amcaUsers = await usersRepository.getAllUsers()
        ..removeWhere(
            (element) => element.identification == currentUser.identification);
    } catch (e) {
    } finally {
      isLoading = false;
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
