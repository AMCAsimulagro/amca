/// {@category Api}
/// This file contains the implementation of an interface `UsersApi` and its adapter `UsersApiAdapter`
/// 
/// which provide methods to interact with the Firestore database in a Flutter application specifically for managing user data.
/// These methods are designed for retrieving all users and managing admin users.

/// Imports of Bookstores and Resources
import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract interface defining methods to interact with Firestore database specifically for managing user data.
abstract class UsersApi {
  Future<List<AmcaUser>> getAllUsers();/// Retrieves all users from the database.

  Future<AmcaUser> manageAdminUser(AmcaUser user); /// Manages an admin user by adding or updating their information in the database.
}

/// Implementation of the `UsersApi` interface.
class UsersApiAdapter extends UsersApi {
  final _firebaseDb = FirebaseFirestore.instance;

  @override
  Future<List<AmcaUser>> getAllUsers() async {
    try {
      final collection =
          await _firebaseDb.collection(FirebaseCollections.users).get();
      final data =
          collection.docs.map((doc) => AmcaUser.fromJson(doc.data())).toList();
      return data;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        message: e.message,
        codeError: e.code,
      );
    } catch (e) {
      throw AppException(
        codeError: Constants.generalError,
      );
    }
  }

  @override
  Future<AmcaUser> manageAdminUser(AmcaUser user) async {
    try {
      await _firebaseDb
          .collection(FirebaseCollections.users)
          .doc(user.identification)
          .set(user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        message: e.message,
        codeError: e.code,
      );
    } catch (e) {
      throw AppException(
        codeError: Constants.generalError,
      );
    }
  }
}
