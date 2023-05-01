import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginApi {
  Future<UserCredential> createUserWithEmailAndPassword(
    AmcaUser user,
    String password,
  );

  Future<UserCredential> signInWithIdentificationAndPassword(
      String identification, String password);

  Future<void> sendPasswordResetEmail(String email);

  Future<bool> isLogged();

  Future<void> signOut();
}

class LoginApiAdapter extends LoginApi {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseDb = FirebaseFirestore.instance;

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      AmcaUser user, String password) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      user.uid = result.user?.uid ?? user.identification;
      await _firebaseDb
          .collection(FirebaseCollections.users)
          .doc(user.identification)
          .set(user.toJson());
      return result;
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
  Future<UserCredential> signInWithIdentificationAndPassword(
      String identification, String password) async {
    try {

      final collection = await _firebaseDb
          .collection(FirebaseCollections.users)
          .doc(identification)
          .withConverter(
            fromFirestore: AmcaUser.fromFirestore,
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      final user = collection.data();
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: user?.email ?? 'amca@test.com', password: password);
      return result;
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
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      var result = await _firebaseAuth.sendPasswordResetEmail(email: email);
      return result;
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
  Future<bool> isLogged() async {
    try {
      return _firebaseAuth.currentUser != null;
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
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
