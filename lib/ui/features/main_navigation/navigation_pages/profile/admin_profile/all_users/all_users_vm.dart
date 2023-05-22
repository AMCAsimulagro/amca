import 'package:amca/data/repository/users_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:flutter/cupertino.dart';

class AllUsersVM extends ChangeNotifier {
  final UsersRepository usersRepository = locator<UsersRepository>();
  List<AmcaUser> amcaUsers = [];

  bool isLoading = true;
  Future<void> init() async {
    isLoading = true;
    try {
      amcaUsers = await usersRepository.getAllUsers();
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
