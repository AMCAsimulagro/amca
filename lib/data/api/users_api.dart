import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UsersApi {
  Future<List<AmcaUser>> getAllUsers();
}

class UsersApiAdapter extends UsersApi {
  final _firebaseDb = FirebaseFirestore.instance;

  @override
  Future<List<AmcaUser>> getAllUsers() async {
    try {
      final collection =
          await _firebaseDb.collection(FirebaseCollections.users).get();
      final data = collection.docs
          .map((doc) => AmcaUser.fromJson(doc.data()))
          .toList();
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
}
