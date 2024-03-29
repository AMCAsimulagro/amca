/// {@category Api}
/// This file contains the implementation of an interface `LoginApi` and its adapter `LoginApiAdapter`
/// 
/// which provide methods to interact with Firebase authentication and Firestore database in a Flutter application specifically for user authentication.
/// These methods are designed for user account creation, login, password recovery, account deletion, and retrieval of the currently logged-in user.

/// Imports of Bookstores and Resources
import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/data/local_storage/shared_preferences_keys.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract interface defining methods to interact with Firebase authentication and Firestore database specifically for user authentication.
abstract class LoginApi {
  Future<UserCredential> createUserWithEmailAndPassword(
    AmcaUser user,
    String password,
  );/// Creates a user account with email and password.

  Future<UserCredential> signInWithIdentificationAndPassword(
      String identification, String password);/// Signs in a user with identification (e.g., email) and password.

  Future<void> sendPasswordResetEmail(String email);/// Sends a password reset email to the specified email address.

  Future<bool> isLogged();/// Checks if a user is currently logged in.

  Future<void> signOut();/// Signs out the currently logged-in user.

  Future<AmcaUser> getUserCurrentlyLogged();/// Retrieves the currently logged-in user.

  Future<void> recoverPassword(String email);/// Initiates the process of recovering the password for the specified email address.

  Future<void> deleteAccount();/// Deletes the user account associated with the currently logged-in user.
}

/// Implementation of the `LoginApi` interface.
class LoginApiAdapter extends LoginApi {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseDb = FirebaseFirestore.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      AmcaUser user, String password) async {
    try {
      var collectionRef = _firebaseDb.collection(FirebaseCollections.users);
      final userDb = await collectionRef.doc(user.identification).get();
      if (userDb.exists) {
        throw FirebaseAuthException(
            message: 'This document is already in use',
            code: 'already_exist_identification');
      }
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
      final SharedPreferences prefs = await _prefs;
      await prefs.setString(
          SharedPreferencesKey.currentlyUserLoggedIdentification,
          identification);
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

  @override
  Future<AmcaUser> getUserCurrentlyLogged() async {
    try {
      final SharedPreferences prefs = await _prefs;
      final collection = await _firebaseDb
          .collection(FirebaseCollections.users)
          .doc(prefs.getString(
              SharedPreferencesKey.currentlyUserLoggedIdentification))
          .withConverter(
            fromFirestore: AmcaUser.fromFirestore,
            toFirestore: (model, _) => model.toJson(),
          )
          .get();
      final user = collection.data();
      return Future.value(user);
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
  Future<void> recoverPassword(String email) async {
    try {
      return await _firebaseAuth
          .sendPasswordResetEmail(email: email);
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
  Future<void> deleteAccount() async {
    try {
      final SharedPreferences prefs = await _prefs;
      final identification = prefs.getString(
          SharedPreferencesKey.currentlyUserLoggedIdentification);
      var collectionRef = _firebaseDb.collection(FirebaseCollections.users);
      final userDb = await collectionRef.doc(identification).delete();
      return await _firebaseAuth.currentUser?.delete();
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
